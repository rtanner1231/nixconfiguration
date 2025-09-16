{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.packages = with pkgs; [
    delta
    lazygit
    gh
    meld
  ];

  xdg.configFile."lazygit" = {
    source = create_symlink "${dotfiles}/.config/lazygit";
    recursive = true;
  };

  home.file.".gitconfig".source = create_symlink "${dotfiles}/.gitconfig";

}
