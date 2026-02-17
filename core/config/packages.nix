{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    git
    vim
    wget
    clang
    libsecret
    seahorse
    inputs.sfdx.packages.${pkgs.stdenv.hostPlatform.system}.default
    lm_sensors
    inputs.apex-ls.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
