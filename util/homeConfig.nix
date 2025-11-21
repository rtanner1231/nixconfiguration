{
  inputs,
  lib,
  pkgs,
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

    users."${profile.user}" = {
      imports = [
        wmHome
        inputs.suitecloud.homeManagerModules.${pkgs.stdenv.hostPlatform.system}.default
      ]
      ++ lib.optional (builtins.pathExists profileHomeFile) profileHomeFile;
      home = {
        username = profile.user;
        homeDirectory = "/home/${profile.user}";
        stateVersion = "24.05";
      };
      programs.home-manager.enable = true;
    };
  };

  # Also use the 'username' argument here
  nix.settings.allowed-users = [ profile.user ];
}
