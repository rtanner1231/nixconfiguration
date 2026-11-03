{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "eDP-1";
        mode = "3840x2160@60";
        position = "0x0";
        scale = 2;
      }
      {
        output = "HDMI-A-1";
        mode = "1920x1080@60";
        position = "1920x0";
        scale = 1;
      }
    ];
  };
}
