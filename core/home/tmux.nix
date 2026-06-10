{ pkgs, ... }:
let
  # This inlines the environment selector script and handles dependencies cleanly via Nix
  ns-env-selector = pkgs.writeShellScript "ns-env-selector" ''
    CONFIG_FILE="$HOME/.config/netsuite_mcp/config.json"

    # Ensure the directory exists
    mkdir -p "$(dirname "$CONFIG_FILE")"

    # Use fzf to display the menu and capture the selection
    CHOICE=$(printf "SB1\nSB2\nProd" | ${pkgs.fzf}/bin/fzf --prompt="Select NetSuite Environment: " --height=100% --layout=reverse --border)

    # If the user made a selection (didn't press ESC)
    if [ -n "$CHOICE" ]; then
        # If the config file doesn't exist yet, initialize it as empty JSON
        [ ! -f "$CONFIG_FILE" ] && echo "{}" > "$CONFIG_FILE"
        
        # Safely update the environment key using jq and a temporary file
        TMP_FILE=$(mktemp)
        ${pkgs.jq}/bin/jq --arg env "$CHOICE" '.environment = $env' "$CONFIG_FILE" > "$TMP_FILE" && mv "$TMP_FILE" "$CONFIG_FILE"
        
        # Send a success message to the active tmux session
        ${pkgs.tmux}/bin/tmux display-message "NetSuite environment updated to: $CHOICE"
    fi
  '';
in
{
  programs.tmux = {
    enable = true;

    # Basic configuration
    baseIndex = 1;
    escapeTime = 50;
    mouse = true;
    keyMode = "vi";

    # Set the prefix key to Ctrl + Space
    prefix = "C-Space";

    # Tmux Plugin Manager (TPM)
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      resurrect
      continuum
    ];

    # Configuration options that don't have a dedicated Home Manager setting
    extraConfig = ''
      # Set fish as the default shell/command
      set -g default-command ${pkgs.fish}/bin/fish

      bind f kill-pane -a

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      unbind J
      bind J run-shell "tmux-sessionizer --root $HOME/projects/ --maxdepth 1"

      # Open panes in the current directory
      bind '_' split-window -v -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"

      # Set true colors and focus events
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g focus-events on
      set-option -g renumber-windows on

      # Restore sessions on tmux startup
      set -g @continuum-restore 'on'

      # Status bar customization
      set -g status-interval 10
      set -g status-justify left
      set -g status-position bottom
      set -g status-left-length 200
      set -g status-style 'bg=default' # transparent background

      bind e display-popup -E -w 40 -h 10 "${ns-env-selector}"
    '';
  };
}
