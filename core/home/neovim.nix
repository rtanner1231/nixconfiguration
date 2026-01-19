{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.packages = with pkgs; [
    lua-language-server
    typescript-language-server
    bash-language-server
    sqls
    nil # nix LSP
    yaml-language-server
    clang-tools
    nixfmt-rfc-style # nix formatter
    vue-language-server
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };

  xdg.configFile."nvim" = {
    source = create_symlink "${dotfiles}/.config/nvim";
    recursive = true;
  };

}
