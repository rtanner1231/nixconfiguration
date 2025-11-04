{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{

  imports = [
    ./tmux.nix
    ./scripts/tmux-sessionizer.nix
  ];

  home.packages = with pkgs; [
    ghostty
    fish
    starship
    zoxide
  ];

  xdg.configFile."ghostty" = {
    source = create_symlink "${dotfiles}/.config/ghostty";
    recursive = true;
  };

  xdg.configFile."fish" = {
    source = create_symlink "${dotfiles}/.config/fish";
    recursive = true;
  };

  xdg.configFile."starship.toml".source = create_symlink "${dotfiles}/.config/starship.toml";

  programs.fzf = {
    enable = true;
    tmux.enableShellIntegration = true;
  };

  programs.sesh = {
    enable = true;
  };

}
