{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nemo-with-extensions
    gnome-screenshot
    gedit
  ];
}
