{
  config,
  pkgs,
  lib,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.packages = with pkgs; [
    # Language Servers
    lua-language-server
    vtsls
    vue-language-server
    bash-language-server
    sqls
    nil # nix LSP
    yaml-language-server
    clang-tools # provides clangd

    # Formatters & Linters (used by conform.nvim)
    prettier
    stylua
    nixfmt

    # Build tools required by nvim-treesitter (main branch) and telescope-fzf-native
    gcc
    gnumake
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withRuby = false;
    withPython3 = false;
    extraLuaPackages = ps: [
      ps.jsregexp # Required by LuaSnip for LSP snippet variable/placeholder transformations
    ];
  };

  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
  xdg.configFile."nvim" = {
    source = create_symlink "${dotfiles}/.config/nvim";
    # recursive = true;
  };
}
