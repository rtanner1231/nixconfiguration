{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    ./packages.nix
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      bars = [
        {
          position = "top";
          height = 30;
          modules_left = [ "workspaces" ];
          modules_center = [ "clock" ];
          modules_right = [
            "tray"
            "battery"
            "network"
          ];
        }
      ];
    };
  };
}
