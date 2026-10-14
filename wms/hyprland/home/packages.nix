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
    kdePackages.ark
    kdePackages.kio-extras

    zip
    unzip
    p7zip
    unrar
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    kdePackages.kate
  ];

}
