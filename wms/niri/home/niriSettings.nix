{
  pkgs,
  lib,
  config,
  ...
}:
{
  xdg.configFile."niri/config.kdl" = {
    force = true;
    source = ./config/config.kdl;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };
}
