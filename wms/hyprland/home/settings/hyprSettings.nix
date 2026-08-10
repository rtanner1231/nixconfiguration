{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    kitty # Terminal
    swaybg # Wallpaper
    rofi # App launcher
    swaynotificationcenter # Notification daemon
    swaylock # Screen locker
    kdePackages.dolphin
  ];

  wayland.windowManager.hyprland =
    let
      lua = lib.generators.mkLuaInline;
      on = event: body: {
        _args = [
          event
          (lua "function() ${body} end")
        ];
      };
      exec = cmd: ''hl.exec_cmd("${cmd}")'';
    in
    {
      enable = true;
      configType = "lua";
      settings = {
        config = {
          general = {
            layout = "scrolling";
            resize_on_border = true;
            gaps_in = 8;
            gaps_out = 8;
            border_size = 4;
          };

          # Define explicit monitor layout
          monitor = [
            "eDP-1, 3840x2160@60, 0x0, 2"
            "HDMI-A-1, 1920x1080@60, 1920x0, 1"
          ];

          xwayland = {
            force_zero_scaling = true;
          };

          scrolling = {
            fullscreen_on_one_column = true;
          };

          env = [
            "NIXOS_OZONE_WL,1"
            "MOZ_ENABLE_WAYLAND,1"
            "XCURSOR_THEME,Adwaita"
            "XCURSOR_SIZE,24"
            "LIBVA_DRIVER_NAME,nvidia"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            "GBM_BACKEND,nvidia-drm"
            "NVD_BACKEND,direct"
            "ELECTRON_OZONE_PLATFORM_HINT,auto"
          ];

          cursor = {
            no_hardware_cursors = true;
            enable_hyprcursor = false;
            warp_on_change_workspace = true;
          };
        };

        on = [
          (on "hyprland.start" ''
            ${exec "hyprctl setcursor Adwaita 24"}
          '')
        ];
      };
    };
}
