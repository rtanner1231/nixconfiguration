{ pkgs, ... }:

let
  # 1. Define the content of your script as a string.
  #    Use an indented string ('''') to allow Nix-style interpolation.
  sessionizerScriptContent = ''
    #!${pkgs.bash}/bin/bash

    # This script, when run from within tmux, displays a popup window
    # with an fzf selector to choose a subdirectory.
    # It then
    # creates a new tmux session for that directory or switches to it
    # if one already exists.
    #
    # It accepts a '--root' argument to specify the search directory.
    # Defaults to $HOME.
    # It also accepts a '--maxdepth' argument to pass to 'find'.
    # 1. Define the function that handles the session logic.
    handle_tmux_session() {
        # fzf passes the selected line as the first argument.
        # If empty (e.g., user pressed Esc), just exit.
        if [ -z "$1" ];
        then
            exit 0
        fi

        # Use absolute paths for all executables.
        SELECTED_DIR=$(${pkgs.coreutils}/bin/realpath "$1")
        
        # Create a session name from the directory's basename.
        # Replace any dots with underscores (e.g., .config -> _config)
        # to avoid issues with tmux session names.
        SESSION_NAME=$(${pkgs.coreutils}/bin/basename "$SELECTED_DIR" | ${pkgs.coreutils}/bin/tr '.' '_')

        # Check if a session with this name already exists.
        if ${pkgs.tmux}/bin/tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
            # Session exists.
            # Switch the client to it.
            # This will automatically close the popup.
            ${pkgs.tmux}/bin/tmux switch-client -t "$SESSION_NAME"
        else
            # Session does not exist.
            # Create a new one.
            # -d: detached (don't switch to it yet)
            # -s: session name
            # -c: working directory
            ${pkgs.tmux}/bin/tmux new-session -d -s "$SESSION_NAME" -c "$SELECTED_DIR"
            
            # Now, switch the client to the newly created session.
            ${pkgs.tmux}/bin/tmux switch-client -t "$SESSION_NAME"
        fi
    }

    # 2. Check for the internal '--run-function' call from fzf *first*.
    #    This is the most specific command and should be handled immediately.
    #    Escaped the '$' so Nix treats ''\${"1:-"} as a literal string
    #    for bash, not a Nix interpolation.
    if [ "''${1:-}" = "--run-function" ]; then
        shift # Removes '--run-function'
        # Also escaped the '$' here.
        handle_tmux_session "''${1:-}" # Calls the function with the path from fzf
        exit 0 # Exit successfully after the function runs
    fi

    # 3. Handle command-line arguments for the main script execution.
    #    Initialize the search root to $HOME.
    SEARCH_ROOT="$HOME"
    MAX_DEPTH_ARG="" # Initialize max depth

    # Simple loop to parse arguments.
    # We only care about '--root' and '--maxdepth' here.
    while [ $# -gt 0 ];
    do
        case "$1" in
            --root)
                # Check if a value was provided after --root
                if [ -n "$2" ];
                then
                    SEARCH_ROOT="$2"
                    shift 2 # Consume --root and its value
                else
                    echo "Error: --root requires an argument." >&2
                    exit 1
                fi
                ;;
            --maxdepth)
                # Check if a value was provided after --maxdepth
                if [ -n "$2" ];
                then
                    MAX_DEPTH_ARG="$2"
                    shift 2 # Consume --maxdepth and its value
                else
                    echo "Error: --maxdepth requires an argument." >&2
                    exit 1
                fi
                ;;
            *)
                # Unknown argument, stop parsing.
                break
                ;;
        esac
    done

    # Get the absolute path for the search root
    SEARCH_ROOT=$(${pkgs.coreutils}/bin/realpath "$SEARCH_ROOT")

    # Export the variable so the inner shell used by `tmux popup` can see it.
    export SEARCH_ROOT

    # 4. Check if we are inside a tmux session.
    #    This check happens *after* the argument parsing.
    if [ -z "$TMUX" ];
    then
        echo "Error: This script must be run from within a tmux session." >&2
        exit 1
    fi

    # 5. Prepare the find command arguments
    MAX_DEPTH_FLAG=""
    if [ -n "$MAX_DEPTH_ARG" ]; then
        MAX_DEPTH_FLAG="-maxdepth $MAX_DEPTH_ARG"
    fi

    # 6. Call `tmux popup` to display fzf.
    #    - The 'execute' binding now calls 'tmux-sessionizer' (this script)
    #      with the special '--run-function' argument.
    #    - The 'find' command now uses $SEARCH_ROOT and $MAX_DEPTH_FLAG.
    #    - Inside the Nix string, this becomes \$SEARCH_ROOT.
    #    - The script's "..." string then escapes this to $SEARCH_ROOT.
    #    - The bash -c command finally receives $SEARCH_ROOT and expands it
    #      because it was exported.
    ${pkgs.tmux}/bin/tmux popup -E -w 80% -h 80% \
        "${pkgs.bash}/bin/bash -c \" \
            (${pkgs.findutils}/bin/find $SEARCH_ROOT $MAX_DEPTH_FLAG -mindepth 1 -type d -not -path '*/[@.]*' 2>/dev/null | \
             ${pkgs.fzf}/bin/fzf --height 100% --reverse --prompt 'Select Directory: ' \
                     --bind \\\"enter:execute(tmux-sessionizer --run-function {})+accept\\\" \
             
            --bind \\\"esc:abort\\\") 2> /tmp/tmux_fzf.log \
        \""
  '';
in
{
  # 2. Use `pkgs.writeShellApplication` to create a package for your script.
  #    This package will be installed into your profile.
  home.packages = [
    (pkgs.writeShellApplication {
      name = "tmux-sessionizer";

      # 3. Add the script's runtime dependencies.
      runtimeInputs = [
        pkgs.bash
        pkgs.fzf
        pkgs.tmux
        pkgs.coreutils
        pkgs.findutils
      ];

      # 4. Pass the script content.
      text = sessionizerScriptContent;
    })
  ];
}
