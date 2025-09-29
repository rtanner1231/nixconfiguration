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
    sfdx = {
      url = "github:rfaulhaber/sfdx-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    suitecloud.url = "path:./suitecloudflake";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      wms = [
        "gnome"
        "cinnamon"
        "kde"
        "hyprland"
        "niri"
      ];
      profiles = [
        {
          name = "l2";
          path = ./profiles/l2;
        }
      ];
      system = "x86_64-linux";
      makeSystem =
        {
          profile,
          additionalModules ? [ ],
          wm,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit wm inputs profile;
          };
          modules = [
            profile.path
            inputs.nix-sweep.nixosModules.default
          ]
          ++ additionalModules;
        };
      allCombinations = nixpkgs.lib.concatMap (
        profile:
        builtins.map (wm: {
          name = "${profile.name}-${wm}";
          value = makeSystem {
            profile = profile;
            wm = wm;
          };
        }) wms
      ) profiles;
    in
    {
      nixosConfigurations = nixpkgs.lib.listToAttrs allCombinations;
    };
}
