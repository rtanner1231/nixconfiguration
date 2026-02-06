{
  ...
}:
{
  programs.niri.settings.binds = {

    # -- Workspaces --
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+0".action.focus-workspace = 10;

    # -- Move Window to Workspace --
    "Mod+Shift+1".action.move-window-to-workspace = 1;
    "Mod+Shift+2".action.move-window-to-workspace = 2;
    "Mod+Shift+3".action.move-window-to-workspace = 3;
    "Mod+Shift+4".action.move-window-to-workspace = 4;
    "Mod+Shift+5".action.move-window-to-workspace = 5;
    "Mod+Shift+6".action.move-window-to-workspace = 6;
    "Mod+Shift+7".action.move-window-to-workspace = 7;
    "Mod+Shift+8".action.move-window-to-workspace = 8;
    "Mod+Shift+9".action.move-window-to-workspace = 9;
    "Mod+Shift+0".action.move-window-to-workspace = 10;

    # -- Applications --
    "Mod+E".action.spawn-sh = "ghostty -e yazi";
    "Mod+U".action.spawn-sh = "ghostty -e tmux new -A -s scratch";
    "Alt+F".action.spawn = "firefox";

    # "Mod+D".action.spawn = "rofi-launcher";
    "Mod+D".action.spawn-sh = "noctalia-shell ipc call launcher toggle";

    # -- Window & Session Management --
    "Mod+O" = {
      repeat = false;
      action.toggle-overview = [ ];
    };

    "Mod+Q".action.close-window = [ ];
    "Mod+Shift+Q".action.quit.skip-confirmation = true;

    # -- Focus Movement --
    "Mod+H".action.focus-column-or-monitor-left = [ ];
    "Mod+J".action.focus-window-down = [ ];
    "Mod+K".action.focus-window-up = [ ];
    "Mod+L".action.focus-column-or-monitor-right = [ ];

    # -- Window Movement --
    "Mod+Shift+H".action.move-window-to-monitor-left = [ ];
    "Mod+Shift+J".action.move-window-down-or-to-workspace-down = [ ];
    "Mod+Shift+K".action.move-window-up-or-to-workspace-up = [ ];
    "Mod+Shift+L".action.move-window-to-monitor-right = [ ];

    # -- Workspace Focus --
    "Mod+Ctrl+J".action.focus-workspace-down = [ ];
    "Mod+Ctrl+K".action.focus-workspace-up = [ ];
    "Mod+Ctrl+H".action.focus-monitor-left = [ ];
    "Mod+Ctrl+L".action.focus-monitor-right = [ ];

    # -- Workspace Movement --
    "Mod+Alt+J".action.move-workspace-down = [ ];
    "Mod+Alt+K".action.move-workspace-up = [ ];
    "Mod+Alt+H".action.move-workspace-to-monitor-left = [ ];
    "Mod+Alt+L".action.move-workspace-to-monitor-right = [ ];

    # -- Menus --
    # "Mod+Ctrl+P".action.spawn = "rofi-switchwm";
    # "Mod+Ctrl+Z".action.spawn = "rofi-powermenu";
    "Mod+Ctrl+Z".action.spawn-sh = "noctalia-shell ipc call sessionMenu toggle";

    # -- Column Layout Operations --
    "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
    "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
    "Mod+Comma".action.consume-window-into-column = [ ];
    "Mod+Period".action.expel-window-from-column = [ ];

    "Mod+R".action.switch-preset-column-width = [ ];
    "Mod+Shift+R".action.switch-preset-column-width = [ ];
    "Mod+F".action.maximize-column = [ ];
    "Mod+Shift+F".action.fullscreen-window = [ ];
    "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];
    "Mod+C".action.center-column = [ ];
    "Mod+Ctrl+C".action.center-visible-columns = [ ];

    # -- Fine-grained Sizing --
    "Mod+Ctrl+Shift+H".action.set-column-width = "-10%";
    "Mod+Ctrl+Shift+L".action.set-column-width = "+10%";
    "Mod+Ctrl+Shift+J".action.set-window-height = "-10%";
    "Mod+Ctrl+Shift+K".action.set-window-height = "+10%";

    # -- Floating --
    "Mod+V".action.toggle-window-floating = [ ];
    "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];

    # -- Screenshots --
    "Shift+Mod+S".action.spawn = "screenshotcopy";
    "Alt+Mod+S".action.screenshot-screen = [ ];
    "Ctrl+Mod+S".action.spawn = "screenshotannotate";

    # -- Miscellaneous --
    "Mod+G".action.toggle-column-tabbed-display = [ ];
    "Mod+T".action.spawn-sh = "pkill -SIGUSR1 wayscriber";

    "Mod+Escape" = {
      allow-inhibiting = false;
      action.toggle-keyboard-shortcuts-inhibit = [ ];
    };

    # "Mod+B".action.spawn-sh = "rofi -show clipboard ...";
    "Mod+B".action.spawn-sh = "noctalia-shell ipc call launcher clipboard";
    "Mod+W".action.spawn-sh = "noctalia-shell ipc call launcher windows";

    "Mod+Shift+P".action.power-off-monitors = [ ];

    # -- Column Width Presets --
    "Mod+F1".action.set-column-width = "25%";
    "Mod+F2".action.set-column-width = "50%";
    "Mod+F3".action.set-column-width = "75%";
    "Mod+F4".action.set-column-width = "100%";

    # -- Media Keys --
    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [
        "brightnessctl"
        "set"
        "5%+"
      ];
    };

    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [
        "brightnessctl"
        "set"
        "5%-"
      ];
    };

    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1+"
      ];
    };

    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1-"
      ];
    };

    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SINK@"
        "toggle"
      ];
    };

    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SOURCE@"
        "toggle"
      ];
    };
  };
}
