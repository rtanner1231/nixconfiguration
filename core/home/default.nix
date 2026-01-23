{
  pkgs,
  inputs,
  profile,
  ...
}:
let
  system = "x86_64-linux";
in
{
  # Import the correct home-manager module based on the desktop choice
  imports = [
    ./neovim.nix
    ./git.nix
    ./terminal.nix
    ./nodejs.nix
    ./yazi.nix
    #./suitecloud
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = profile.user;
  home.homeDirectory = "/home/${profile.user}";

  # Basic user packages that are always installed
  home.packages = with pkgs; [
    firefox
    zoom
    htop
    nerd-fonts.fira-code
    cargo
    fd
    ripgrep
    prefetch-npm-deps
    openjdk
    gh
    thunderbird
    postman
    fastfetch
    jq
    tree
    fastfetch
    baobab
    slack
    btop
    vivaldi
    opencode
    inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
    postman
    libreoffice
    soapui
    imagemagick
    mission-center
    filezilla
    obsidian
    gimp
    lsof
    google-chat-linux
  ];

  fonts.fontconfig.enable = true;

  # Nicely reload systemd units when changing configs.
  systemd.user.startServices = "sd-switch";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.05";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
