{
  inputs,
  lib,
  pkgs,
  username,
  profile,
  wmHome,
  profileHomeFile,
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hmbackup";

    extraSpecialArgs = {
      inherit inputs profile;
      suitecloud = inputs.suitecloud;
    };

    users."${username}" = {
      imports = [
        wmHome
        inputs.suitecloud.homeManagerModules.${pkgs.system}.default
      ]
      ++ lib.optional (builtins.pathExists profileHomeFile) profileHomeFile;
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "24.05";
      };
      programs.home-manager.enable = true;
    };
  };

  # Also use the 'username' argument here
  nix.settings.allowed-users = [ username ];
}
