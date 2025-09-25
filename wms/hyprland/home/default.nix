{ ... }:
{
  imports = [
    ./packages.nix
    ./hyprlandSettings.nix
    ./waybar
    ../../../common/wayland/hyprlock
    ../../../common/wayland/rofi
    ../../../common/wayland/hyprpaper
    ../../../core/home
  ];
}
