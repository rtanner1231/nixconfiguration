{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    waybar # Status bar
    swaynotificationcenter # Notification daemon
    nautilus # File manager
    cliphist
    networkmanagerapplet
    playerctl
    qalculate-gtk
    swaynotificationcenter
    swayosd
    syncthingtray
    wl-clipboard
    wl-clip-persist
    wl-color-picker
    alacritty
  ];

}
