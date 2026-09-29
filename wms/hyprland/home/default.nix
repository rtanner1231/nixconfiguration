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
    # ../../../common/scripts/browser.nix
    ./smartbrowser.nix
    ../../../common/wayland/screenshot
  ];
}
