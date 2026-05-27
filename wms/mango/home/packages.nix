{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
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
    wev
    kdePackages.kate
    wayscriber
    foot
    kitty
    wlr-randr
    khal
    wtype
    satty
  ];

}
