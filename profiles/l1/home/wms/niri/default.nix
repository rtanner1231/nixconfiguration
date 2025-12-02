{ ... }:
{
  programs.niri.settings = {
    outputs = {
      "eDP-1" = {
        mode = {
          width = 3840;
          height = 2160;
          refresh = 59.999;
        };
        position = {
          x = 0;
          y = 0;
        };
        scale = 2.25;
      };
      "HDMI-A-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        position = {
          x = 1707;
          y = 0;
        };
      };
    };
  };
}
