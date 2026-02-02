{
  pkgs,
  lib,
  config,
  ...
}:
{
  # xdg.configFile."niri/config.kdl" = {
  #   force = true;
  #   source = ./config/config.kdl;
  # };

  programs.niri.settings = {
    # This attribute set can be assigned to `programs.niri.settings`
    # in your Home Manager configuration.

    input = {
      keyboard = {
        xkb = {
          layout = "us";
          options = "grp:alt_shift_toggle";
        };
        numlock = true;
      };
      touchpad = {
        tap = true;
      };
      "warp-mouse-to-focus".enable = true;
      "workspace-auto-back-and-forth" = true;
      #"focus-follows-mouse".enable = true;
    };

    layout = {
      gaps = 10;
      "center-focused-column" = "never";

      # (Mod+R)toggles between.
      "preset-column-widths" = [
        { proportion = 0.25; }
        { proportion = 0.5; }
        { proportion = 0.75; }
        { proportion = 1.0; }
      ];
      "preset-window-heights" = [
        { proportion = 0.25; }
        { proportion = 0.5; }
        { proportion = 0.75; }
        { proportion = 1.0; }
      ];
      "default-column-width" = {
        proportion = 0.5;
      };
      "focus-ring" = {
        enable = true;
        width = 2;
        active = {
          color = "#7aa2f7";
        };
      };
      border = {
        width = 1.5;
        active = {
          color = "#0313fc";
        };
        inactive = {
          color = "#7a8570";
        };
        urgent = {
          color = "#9b0000";
        };
      };
      #shadow = {
      #   on = true;
      #   "draw-behind-window" = true;
      #   softness = 0;
      #   spread = 1;
      #   offset = { x = 1; y = 1; };
      #   color = "#2d3228";
      #   "inactive-color" = "#2d3228";
      # };
    };

    workspaces = {
      "media" = { };
    };

    gestures = {
      hot-corners.enable = false;
    };

    "window-rules" = [
      #   # {
      #   #   matches = [
      #   #     {
      #   #       "at-startup" = true;
      #   #       "app-id" = "r#\"thunderbird\"#";
      #   #     }
      #   #     {
      #   #       "at-startup" = true;
      #   #       "app-id" = "r#\"Slack\"#";
      #   #     }
      #   #   ];
      #   #   "open-on-workspace" = "media";
      #   #   "open-maximized" = true;
      #   # }
      #   {
      #     matches = [
      #       { "app-id" = "r#\"^org\\.wezfurlong\\.wezterm$\"#"; }
      #     ];
      #     "default-column-width" = { };
      #   }
      #   {
      #     matches = [
      #       {
      #         "app-id" = "r#\"firefox$\"#";
      #         title = "^Picture-in-Picture$";
      #       }
      #     ];
      #     "open-floating" = true;
      #   }
      {
        matches = [ ]; # Applies to all windows
        "geometry-corner-radius" = {
          "top-left" = 12.0;
          "top-right" = 12.0;
          "bottom-right" = 12.0;
          "bottom-left" = 12.0;
        };
        "clip-to-geometry" = true;
      }
      {
        matches = [
          {
            "is-focused" = true;
            "app-id" = "com.mitchellh.ghostty";
          }
        ];
        opacity = 0.9;
      }
      {
        matches = [
          {
            "is-focused" = false;
            "app-id" = "com.mitchellh.ghostty";
          }
        ];
        opacity = 0.7;
      }
    ];
    #
    "layer-rules" = [
      {
        matches = [
          { namespace = "^noctalia-overview*"; }
        ];
        place-within-backdrop = true;
      }
      # {
      #     # matches = [
      #     #   { namespace = "waybar"; }
      #     #   { "at-startup" = true; }
      #     # ];
      #     shadow = {
      #       enable = true; # Was 'on'
      #       "draw-behind-window" = true;
      #       softness = 0;
      #       spread = 0.5;
      #       offset = {
      #         x = 0.5;
      #         y = 0.5;
      #       };
      #       color = "#2d3228";
      #       "inactive-color" = "#2d3228";
      #     };
      #   }
      #   {
      #     matches = [
      #       { namespace = "^launcher$"; }
      #     ];
      #     shadow = {
      #       enable = true; # Was 'on'
      #       "draw-behind-window" = true;
      #       softness = 0;
      #       spread = 1;
      #       offset = {
      #         x = 1;
      #         y = 1;
      #       };
      #       color = "#2d3228";
      #       "inactive-color" = "#2d3228";
      #     };
      #   }
    ];
    "prefer-no-csd" = true;
    # animations = { off = true;};
    "hotkey-overlay" = {
      "skip-at-startup" = true;
    };
    "screenshot-path" = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    "spawn-at-startup" = [
      { argv = [ "snixembed" ]; }
      #{ argv = [ "waybar" ]; }
      # { argv = [ "thunderbird" ]; }
      # { argv = [ "slack" ]; }
      {
        argv = [ "noctalia-shell" ];
      }
      {
        argv = [
          "wayscriber"
          "--daemon"
        ];
      }
      #{ argv = [ "noctalia-shell" ]; }
      # { argv = [ "swww-daemon" ]; }
      # { argv = [ "swww", "img", "~/.mine/dots/wallpapers/1.png" ]; } # Example of command with args
      # { argv = [ "systemctl", "--user", "start", "hyprpolkitagent" ]; }
    ];
    cursor = {
      size = 24;
      theme = "Adwaita";
    };
    binds = {
      "Mod+1".action."focus-workspace" = 1;
      "Mod+2" = {
        action = {
          "focus-workspace" = 2;
        };
      };
      "Mod+3" = {
        action = {
          "focus-workspace" = 3;
        };
      };
      "Mod+4" = {
        action = {
          "focus-workspace" = 4;
        };
      };
      "Mod+5" = {
        action = {
          "focus-workspace" = 5;
        };
      };
      "Mod+6" = {
        action = {
          "focus-workspace" = 6;
        };
      };
      "Mod+7" = {
        action = {
          "focus-workspace" = 7;
        };
      };
      "Mod+8" = {
        action = {
          "focus-workspace" = 8;
        };
      };
      "Mod+9" = {
        action = {
          "focus-workspace" = 9;
        };
      };
      "Mod+0" = {
        action = {
          "focus-workspace" = 10;
        };
      };

      "Mod+Shift+1" = {
        action = {
          "move-window-to-workspace" = 1;
        };
      };
      "Mod+Shift+2" = {
        action = {
          "move-window-to-workspace" = 2;
        };
      };
      "Mod+Shift+3" = {
        action = {
          "move-window-to-workspace" = 3;
        };
      };
      "Mod+Shift+4" = {
        action = {
          "move-window-to-workspace" = 4;
        };
      };
      "Mod+Shift+5" = {
        action = {
          "move-window-to-workspace" = 5;
        };
      };
      "Mod+Shift+6" = {
        action = {
          "move-window-to-workspace" = 6;
        };
      };
      "Mod+Shift+7" = {
        action = {
          "move-window-to-workspace" = 7;
        };
      };
      "Mod+Shift+8" = {
        action = {
          "move-window-to-workspace" = 8;
        };
      };
      "Mod+Shift+9" = {
        action = {
          "move-window-to-workspace" = 9;
        };
      };
      "Mod+Shift+0" = {
        action = {
          "move-window-to-workspace" = 10;
        };
      };
      "Mod+E" = {
        action = {
          spawn-sh = "ghostty -e yazi";
        };
      };
      "Mod+U" = {
        action = {
          spawn-sh = "ghostty -e tmux new -A -s scratch";
        };
      };
      "Alt+F" = {
        action = {
          spawn = "firefox";
        };
      };
      # "Mod+D" = {
      #   action = {
      #     spawn = "rofi-launcher";
      #   };
      # };
      "Mod+D" = {
        action = {
          spawn-sh = "noctalia-shell ipc call launcher toggle";
        };
      };
      "Mod+O" = {
        repeat = false;
        action = {
          "toggle-overview" = [ ];
        };
      };
      "Mod+Q" = {
        action = {
          "close-window" = [ ];
        };
      };
      "Mod+Shift+Q" = {
        action = {
          quit = {
            "skip-confirmation" = true;
          };
        };
      };
      "Mod+H" = {
        action = {
          "focus-column-or-monitor-left" = [ ];
        };
      };
      "Mod+J" = {
        action = {
          "focus-window-down" = [ ];
        };
      };
      "Mod+K" = {
        action = {
          "focus-window-up" = [ ];
        };
      };
      "Mod+L" = {
        action = {
          "focus-column-or-monitor-right" = [ ];
        };
      };
      "Mod+Shift+H" = {
        action = {
          "move-window-to-monitor-left" = [ ];
        };
      };
      "Mod+Shift+J" = {
        action = {
          "move-window-down-or-to-workspace-down" = [ ];
        };
      };
      "Mod+Shift+K" = {
        action = {
          "move-window-up-or-to-workspace-up" = [ ];
        };
      };
      "Mod+Shift+L" = {
        action = {
          "move-window-to-monitor-right" = [ ];
        };
      };
      "Mod+Ctrl+J" = {
        action = {
          "focus-workspace-down" = [ ];
        };
      };
      "Mod+Ctrl+K" = {
        action = {
          "focus-workspace-up" = [ ];
        };
      };
      "Mod+Ctrl+H" = {
        action = {
          "focus-monitor-left" = [ ];
        };
      };
      "Mod+Ctrl+L" = {
        action = {
          "focus-monitor-right" = [ ];
        };
      };
      "Mod+Alt+J" = {
        action = {
          "move-workspace-down" = [ ];
        };
      };
      "Mod+Alt+K" = {
        action = {
          "move-workspace-up" = [ ];
        };
      };
      "Mod+Alt+H" = {
        action = {
          "move-workspace-to-monitor-left" = [ ];
        };
      };
      "Mod+Alt+L" = {
        action = {
          "move-workspace-to-monitor-right" = [ ];
        };
      };
      # "Mod+Ctrl+P" = {
      #   action = {
      #     spawn = "rofi-switchwm";
      #   };
      # };
      # "Mod+Ctrl+Z" = {
      #   action = {
      #     spawn = "rofi-powermenu";
      #   };
      # };

      "Mod+Ctrl+Z" = {
        action = {
          spawn-sh = "noctalia-shell ipc call sessionMenu toggle";
        };
      };
      "Mod+BracketLeft" = {
        action = {
          "consume-or-expel-window-left" = [ ];
        };
      };
      "Mod+BracketRight" = {
        action = {
          "consume-or-expel-window-right" = [ ];
        };
      };
      "Mod+Comma" = {
        action = {
          "consume-window-into-column" = [ ];
        };
      };
      "Mod+Period" = {
        action = {
          "expel-window-from-column" = [ ];
        };
      };
      "Mod+R" = {
        action = {
          "switch-preset-column-width" = [ ];
        };
      };
      "Mod+Shift+R" = {
        action = {
          "switch-preset-column-width" = [ ];
        };
      };
      "Mod+F" = {
        action = {
          "maximize-column" = [ ];
        };
      };
      "Mod+Shift+F" = {
        action = {
          "fullscreen-window" = [ ];
        };
      };
      "Mod+Ctrl+F" = {
        action = {
          "expand-column-to-available-width" = [ ];
        };
      };
      "Mod+C" = {
        action = {
          "center-column" = [ ];
        };
      };
      "Mod+Ctrl+C" = {
        action = {
          "center-visible-columns" = [ ];
        };
      };
      "Mod+Ctrl+Shift+H" = {
        action = {
          "set-column-width" = "-10%";
        };
      };
      "Mod+Ctrl+Shift+L" = {
        action = {
          "set-column-width" = "+10%";
        };
      };
      "Mod+Ctrl+Shift+J" = {
        action = {
          "set-window-height" = "-10%";
        };
      };
      "Mod+Ctrl+Shift+K" = {
        action = {
          "set-window-height" = "+10%";
        };
      };
      "Mod+V" = {
        action = {
          "toggle-window-floating" = [ ];
        };
      };
      "Mod+Shift+V" = {
        action = {
          "switch-focus-between-floating-and-tiling" = [ ];
        };
      };
      "Shift+Mod+S" = {
        action = {
          spawn = "screenshotcopy";
        };
      };
      "Alt+Mod+S" = {
        action = {
          "screenshot-screen" = [ ];
        };
      };
      "Ctrl+Mod+S" = {
        action = {
          spawn = "screenshotannotate";
        };
      };
      "Mod+W" = {
        action = {
          "toggle-column-tabbed-display" = [ ];
        };
      };
      "Mod+T" = {
        action = {
          "spawn-sh" = "pkill -SIGUSR1 wayscriber";
        };
      };
      "Mod+Escape" = {
        "allow-inhibiting" = false;
        action = {
          "toggle-keyboard-shortcuts-inhibit" = [ ];
        };
      };
      # "Mod+B" = {
      #   action = {
      #     "spawn-sh" =
      #       "rofi -show clipboard -modi 'clipboard:~/.config/rofi/scripts/cliphist-rofi-img' -show-icons -theme '~/.config/rofi/themes/rofi-cliphist-theme.rasi'";
      #   };
      # };
      "Mod+B" = {
        action = {
          "spawn-sh" = "noctalia-shell ipc call launcher clipboard";
        };
      };
      "Mod+Shift+P" = {
        action = {
          "power-off-monitors" = [ ];
        };
      };
      "Mod+F1" = {
        action = {
          "set-column-width" = "25%";
        };
      };
      "Mod+F2" = {
        action = {
          "set-column-width" = "50%";
        };
      };
      "Mod+F3" = {
        action = {
          "set-column-width" = "75%";
        };
      };
      "Mod+F4" = {
        action = {
          "set-column-width" = "100%";
        };
      };
      "XF86MonBrightnessUp" = {
        "allow-when-locked" = true;
        action = {
          spawn = [
            "brightnessctl"
            "set"
            "5%+"
          ];
        };
      };
      "XF86MonBrightnessDown" = {
        "allow-when-locked" = true;
        action = {
          spawn = [
            "brightnessctl"
            "set"
            "5%-"
          ];
        };
      };
      "XF86AudioRaiseVolume" = {
        "allow-when-locked" = true;
        action = {
          spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
        };
      };
      "XF86AudioLowerVolume" = {
        "allow-when-locked" = true;
        action = {
          spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
        };
      };
      "XF86AudioMute" = {
        "allow-when-locked" = true;
        action = {
          spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
        };
      };
      "XF86AudioMicMute" = {
        "allow-when-locked" = true;
        action = {
          spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
        };
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };
}
