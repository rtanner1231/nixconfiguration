{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    foot
  ];

  services.hyprpaper.enable = lib.mkForce false;
  services.cliphist.allowImages = lib.mkForce false;

  wayland.windowManager.hyprland.settings = {
    config = {
      decoration = {
        blur = {
          enabled = false;
        };
        shadow = {
          enabled = false;
        };
      };
    };

    monitor = [
      {
        output = "eDP-1";
        mode = "1920x1080@60.04900";
        position = "0x0";
        scale = 1;
      }
    ];
  };
}
