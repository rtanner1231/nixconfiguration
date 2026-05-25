{ inputs, ... }:
{
  imports = [
    ./dms
    inputs.mangowm.hmModules.mango
    ../../../core/home
    ./mango.nix
    ./packages.nix

  ];

  # Enable the MangoWM home-manager module
  wayland.windowManager.mango.enable = true;
}
