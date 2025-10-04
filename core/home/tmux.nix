{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    # Basic configuration
    baseIndex = 1;
    #paneBaseIndex = 1;
    escapeTime = 50;
    mouse = true;
    keyMode = "vi";

    # Set the prefix key to Ctrl + Space
    prefix = "C-Space";

    # NOTE: The `bind r source-file ...` command has been removed.
    # In NixOS/Home Manager, you should reload your entire configuration
    # via `home-manager switch` instead of manually sourcing the file.

    # Vi-style key bindings for copy mode
    # copyModeKeyMap = {
    #   "v" = "send-keys -X begin-selection";
    #   "C-v" = "send-keys -X rectangle-toggle";
    #   "y" = "send-keys -X copy-selection-and-cancel";
    # };

    # Tmux Plugin Manager (TPM)
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      #yank
      resurrect
      continuum
      #sessionx
      # {
      #   plugin = catppuccin;
      #   # You can configure catppuccin options here if needed, for example:
      #   # extraConfig = "set -g @catppuccin_flavour 'mocha'";
      # }
    ];

    # Configuration options that don't have a dedicated Home Manager setting
    # or are for plugins are placed here.
    extraConfig = ''
       
      # Set fish as the default shell/command
      # Using `${pkgs.fish}/bin/fish` ensures we use the version of fish
      # managed by Nix, which is more reliable than a hardcoded path.
      set -g default-command ${pkgs.fish}/bin/fish

        bind f kill-pane -a

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

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
    '';
  };

}
