{ pkgs, inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];
  programs.dankMaterialShell = {
    enable = true;
    enableVPN = false;
    enableDynamicTheming = true;

    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    niri = {
      enableKeybinds = false;
      enableSpawn = false;
    };
  };
}
