{ pkgs }:

# We MUST use stdenv.mkDerivation to break the recursion.
# We will write the script text with a placeholder,
# and then use 'substituteInPlace' to replace it
# with the derivation's own output path ($out).
pkgs.stdenv.mkDerivation rec {
  name = "tmux-sessionizer";

  # Dependencies needed to build/install the wrapper
  nativeBuildInputs = [ pkgs.makeWrapper ];

  # Dependencies needed at *runtime* by the script.
  # makeWrapper will add these to the script's PATH.
  runtimeInputs = [
    pkgs.bash
    pkgs.fzf
    pkgs.tmux
    pkgs.coreutils
    pkgs.findutils
  ];

  # We pass the script text as an environment variable
  # to the builder.
  scriptText = ''
    #!${pkgs.bash}/bin/bash

    # This script, when run from within tmux, displays a popup window
    # with an fzf selector to choose a subdirectory of $HOME.
    # It then
    # creates a new tmux session for that directory or switches to it
    # if one already exists.

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

    if [ "''${1:-}" = "--run-function" ]; then
        shift # Removes '--run-function'
        handle_tmux_session "''${1:-}" # Calls the function with the path from fzf
        exit 0 # Exit successfully after the function runs
    fi

    # Check if we are inside a tmux session.
    # This must be *after* the
    # function check, as the function check is run *inside* tmux.
    if [ -z "$TMUX" ]; then
        echo "Error: This script must be run from within a tmux session." >&2
        exit 1
    fi

    # 3. Call `tmux popup` to display fzf.
    ${pkgs.tmux}/bin/tmux popup -E -w 80% -h 80% \
        "${pkgs.bash}/bin/bash -c \" \
            (${pkgs.findutils}/bin/find \$HOME -mindepth 1 -maxdepth 1 -type d 2>/dev/null | \
             ${pkgs.fzf}/bin/fzf --height 100% --reverse --prompt 'Select Directory: ' \
                     
                     --bind \\\"enter:execute(@self@/bin/tmux-sessionizer --run-function {})+abort\\\" \
                     
              
           --bind \\\"esc:abort\\\") 2> /tmp/tmux_fzf.log \
        \""
  '';

  dontUnpack = true;

  # We also don't need to patch or configure
  dontPatch = true;
  dontConfigure = true;

  # We just need to run the installPhase
  buildPhase = ''
    # This phase is not needed, 'true' means "success"
    true
  '';

  installPhase = ''
    # Create the bin directory
    mkdir -p $out/bin

    # Write the script text (from the 'scriptText' var) to the file
    echo "$scriptText" > $out/bin/tmux-sessionizer

    # Make it executable
    chmod +x $out/bin/tmux-sessionizer

    # Use 'substituteInPlace' to replace the placeholder
    # '@self@' with the value of '$out' (the store path)
    substituteInPlace $out/bin/tmux-sessionizer \
      --replace '@self@' "$out"

    # Use 'makeWrapper' to add all runtime dependencies
    # to the script's PATH. This isn't strictly necessary
    # since your script uses absolute paths, but it's
    # robust and good practice.
    wrapProgram $out/bin/tmux-sessionizer \
      --prefix PATH : ${pkgs.lib.makeBinPath runtimeInputs}
  '';
}
