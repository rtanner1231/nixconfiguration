{
  description = "System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-sweep = {
      url = "github:jzbor/nix-sweep";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      makeSystem =
        profile:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; }; # Pass inputs to all modules
          modules = [
            profile
            inputs.nix-sweep.nixosModules.default
          ];
        };
    in
    {
      nixosConfigurations.hyprland = makeSystem ./profiles/hyprland;
      nixosConfigurations.gnome = makeSystem ./profiles/gnome;
      nixosConfigurations.cinnamon = makeSystem ./profiles/cinnamon;
      nixosConfigurations.kde = makeSystem ./profiles/kde;

    };
}
