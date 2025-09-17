{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gnome-tweaks
    gnome-console
    nautilus
  ];
}
