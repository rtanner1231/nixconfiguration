{
  pkgs,
  inputs,
  ...
}:
let
  username = "rick";
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
    users.rick = {
      imports = [ ./home.nix ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";
      programs.home-manager.enable = true;
    };
    backupFileExtension = "backup";
  };

  nix.settings.allowed-users = [ "${username}" ];
}
