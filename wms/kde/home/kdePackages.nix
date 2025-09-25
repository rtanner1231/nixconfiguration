{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.spectacle
    kdePackages.kate
  ];
}
