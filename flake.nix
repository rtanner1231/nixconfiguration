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
    suitecloud.url = "github:rtanner1231/suitecloud-nix";
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wayscriber = {
      url = "github:devmobasa/wayscriber";
    };
    # next-event = {
    #   url = "path:/home/rick/projects/qshell-next-event";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # dms = {
    #   url = "github:AvengeMedia/DankMaterialShell/stable";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # quickshell = {
    #   url = "git+https://git.outfoxxed.me/quickshell/quickshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  outputs =
    {
      self,
      nixpkgs,
      niri-flake,
      ...
    }@inputs:
    let
      wms = [
        { name = "gnome"; }
        { name = "cinnamon"; }
        { name = "kde"; }
        { name = "hyprland"; }
        {
          name = "niri";
          additionalModules = [ niri-flake.nixosModules.niri ];
        }
        { name = "cosmic"; }
      ];
      profiles = [
        {
          name = "l2";
          path = ./profiles/l2;
          user = "rick";
          git = {
            userName = "Richard Tanner";
            userEmail = "rtanner@myron.com";
          };
        }
        {
          name = "l1";
          path = ./profiles/l1;
          user = "rick";
          git = {
            userName = "Richard Tanner";
            userEmail = "rtanner@myron.com";
          };
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
          # Removed niri-flake from the base modules list
          modules = [
            profile.path
            inputs.nix-sweep.nixosModules.default
          ]
          ++ additionalModules;
        };
      allCombinations = nixpkgs.lib.concatMap (
        profile:
        builtins.map (wmObj: {
          name = "${profile.name}-${wmObj.name}";
          value = makeSystem {
            profile = profile;
            wm = wmObj.name;
            additionalModules = wmObj.additionalModules or [ ];
          };
        }) wms

      ) profiles;
    in
    {
      nixosConfigurations = nixpkgs.lib.listToAttrs allCombinations;
    };
}
