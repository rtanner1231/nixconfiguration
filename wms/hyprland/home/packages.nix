{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    kitty # Terminal
    swaybg # Wallpaper
    satty
    brave
    swaynotificationcenter # Notification daemon
    swaylock # Screen locker
    kdePackages.dolphin
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    kdePackages.kate
  ];

}
