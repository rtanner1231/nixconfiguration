{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    kitty # Terminal
    waybar # Status bar
    swaybg # Wallpaper
    swaynotificationcenter # Notification daemon
    swaylock # Screen locker
    kdePackages.dolphin
  ];

}
