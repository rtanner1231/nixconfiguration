{ pkgs, inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];
  programs."dank-material-shell" = {
    enable = true;
    enableVPN = false;
    enableDynamicTheming = true;

    systemd = {
      enable = false;
      restartIfChanged = true;
    };
  };
}
