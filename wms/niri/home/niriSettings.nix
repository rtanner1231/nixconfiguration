{
  pkgs,
  lib,
  config,
  ...
}:
{
  xdg.configFile."niri/config.kdl".source = ./config/config.kdl;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };
}
