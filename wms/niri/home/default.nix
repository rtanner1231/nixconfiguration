{ ... }:
{
  imports = [
    ./packages.nix
    ./niriSettings.nix
    ./waybar
    ../../../common/wayland/hyprlock
    ../../../common/wayland/rofi
    ../../../common/wayland/hyprpaper
    ./hypridle
    ../../../core/home
    ../../../common/wayland/screenshot
  ];
}
