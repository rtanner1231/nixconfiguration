{
  inputs,
  pkgs,
  lib,
  wm,
  ...
}:
let
  userModule = import ../../../util/homeConfig.nix;
in
{
  imports = [
    (userModule {
      inherit inputs lib pkgs;
      username = "rick";
      wmHome = ../../../wms/${wm}/home;
      profileHomeFile = ./wms/${wm};
    })
  ];
}
