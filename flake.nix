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
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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
        {
          profile,
          additionalModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; }; # Pass inputs to all modules
          modules = [
            profile
            inputs.nix-sweep.nixosModules.default
          ]
          ++ additionalModules;
        };
    in
    {
      nixosConfigurations.hyprland = makeSystem { profile = ./profiles/hyprland; };
      nixosConfigurations.gnome = makeSystem { profile = ./profiles/gnome; };
      nixosConfigurations.cinnamon = makeSystem { profile = ./profiles/cinnamon; };
      nixosConfigurations.kde = makeSystem { profile = ./profiles/kde; };
      nixosConfigurations.niri = makeSystem {
        profile = ./profiles/niri;
      };

    };
}
