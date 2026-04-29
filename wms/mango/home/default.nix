{ inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.mangowm.hmModules.mango
../../../core/home
    ./mango.nix
    ./packages.nix

  ];

  # Enable the MangoWM home-manager module
  wayland.windowManager.mango.enable = true;
}
