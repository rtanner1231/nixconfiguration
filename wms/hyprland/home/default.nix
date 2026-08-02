{ ... }:
{
  imports = [
    ./packages.nix
    ./hypridle
    ../../../common/wayland/hyprlock
    ../../../common/wayland/rofi
    ../../../common/wayland/hyprpaper
    ../../../core/home
    ./noctalia
    ./settings
  ];
}
