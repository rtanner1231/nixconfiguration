{
  inputs,
  pkgs,
  lib,
  wm,
  profile,
  ...
}:
let
  userModule = import ../../../util/homeConfig.nix;
in
{
  imports = [
    (userModule {
      inherit
        inputs
        lib
        pkgs
        profile
        ;
      wmHome = ../../../wms/${wm}/home;
      profileHomeFile = ./wms/${wm};
    })
  ];
}
