{ pkgs, inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];
  programs."dank-material-shell" = {
    enable = true;
    enableVPN = false;
    enableDynamicTheming = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;

    systemd = {
      enable = false;
      restartIfChanged = true;
    };
  };
}
