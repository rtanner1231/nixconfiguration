{
  inputs,
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
      inherit inputs lib;
      username = "rick";
      wmHome = ../../../wms/${wm}/home;
      profileHomeFile = ./wms/${wm};
    })
  ];
}
