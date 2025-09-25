{ ... }:
{
  imports = [
    ./packages.nix
    ./hyprlandSettings.nix
    ./waybar
    ./hypridle
    ../../../common/wayland/hyprlock
    ../../../common/wayland/rofi
    ../../../common/wayland/hyprpaper
    ../../../core/home
  ];
}
