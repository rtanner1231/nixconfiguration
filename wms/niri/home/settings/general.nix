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

    workspaces = {
      "media" = { };
    };

    gestures = {
      hot-corners.enable = false;
    };

    "prefer-no-csd" = true;
    # animations = { off = true;};
    "hotkey-overlay" = {
      "skip-at-startup" = true;
    };
    "screenshot-path" = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    cursor = {
      size = 24;
      theme = "Adwaita";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };
}
