{
  inputs,
  username,
  homeFile,
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hmbackup";

    extraSpecialArgs = { inherit inputs; };

    users."${username}" = {
      imports = [ homeFile ];
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
