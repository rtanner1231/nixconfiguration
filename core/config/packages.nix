{
  pkgs,
  inputs,
  config,
  ...
}:
{
  environment.systemPackages =
    let
      pinnedPkgs =
        import
          (builtins.fetchTarball {
            url = "https://github.com/NixOS/nixpkgs/archive/3e662c7cafceb2a65f612e1da9dd39f82eb39ad0.tar.gz";
            sha256 = "0px08frimcw464pl7k3jscr8c891diyxw7h1qm5vacdx7p2f8xbr";
          })
          {
            config = config.nixpkgs.config;
            system = pkgs.stdenv.hostPlatform.system;
          };
      opencodePackages = inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system};
      opencodePkg = opencodePackages.opencode.override (prev: {
        node_modules = prev.node_modules.override {
          hash = "sha256-/P9H/srrpVdKB8ylPJPqt1Ouu6e0/chxsGktqfu6bS8=";
        };
      });
      opencodeDesktopPkg =
        (opencodePackages.opencode-desktop.override {
          opencode = opencodePkg;
        }).overrideAttrs
          (old: {
            buildPhase =
              builtins.replaceStrings
                [ ''export OPENCODE_CLI_DIST="$TMPDIR/desktop-cli"'' ]
                [ ''export OPENCODE_CLI_DIST="$PWD/../cli/dist"'' ]
                old.buildPhase;
          });
    in
    with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      git
      vim
      wget
      clang
      libsecret
      seahorse
      lm_sensors
      docker-compose
      python3
      # pinnedPkgs.opencode
      # pinnedPkgs.opencode-desktop
      # opencodePkg
      # opencodeDesktopPkg
      opencode
      opencode-desktop
      openssl
      sqlite
    ];
}
