{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    ./settings.nix
    inputs.dms-plugin-registry.modules.default
  ];
  programs."dank-material-shell" = {
    enable = true;
    enableVPN = false;
    enableDynamicTheming = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;

    managePluginSettings = true;

    systemd = {
      enable = false;
      restartIfChanged = true;
    };

    plugins = {
      unifiedTaskbar = {
        enable = true;
        settings = {
          compactMode = true;
          allMonitors = false;

        };
      };
    };
  };

  home.packages = [
    inputs.dms.packages.${pkgs.system}.quickshell
  ];

  systemd.user.services.dms.Service.Environment =
    lib.mkForce "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin";

  # home.packages = [
  #   inputs.dms.packages.${pkgs.system}.quickshell
  # ];
  #
  # # Force the systemd service to see your normal system/user PATH
  # systemd.user.services.dms.environment = {
  #   PATH = "${config.home.profileDirectory}/bin:/run/current-system/sw/bin";
  # };
}
