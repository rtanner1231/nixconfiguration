{ wm, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../core/config
    ./home
    ../../wms/${wm}
  ];
}
