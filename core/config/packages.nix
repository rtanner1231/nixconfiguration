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
            url = "https://github.com/NixOS/nixpkgs/archive/d91a239ca0118ff10ee22ba54f48929c38ab8114.tar.gz";
            sha256 = "1dwsci1a9d9vib6cjx0kq1zs46vxbn1j1sfd3ly98m708c9w1amr";
          })
          {
            config = config.nixpkgs.config;
            system = pkgs.stdenv.hostPlatform.system;
          };
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
      # inputs.sfdx.packages.${pkgs.stdenv.hostPlatform.system}.default
      lm_sensors
      docker-compose
      python3
      pinnedPkgs.opencode
      pinnedPkgs.opencode-desktop
      # opencode
      # opencode-desktop
      inputs.apex-ls.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
}
