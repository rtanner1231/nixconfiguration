{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    cliphist
    xdg-utils
  ];

  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  xdg.configFile."rofi/scripts/cliphist-rofi-img" = {
    source = pkgs.cliphist.src + "/contrib/cliphist-rofi-img";
    executable = true;
  };

  #home.file.".config/rofi/scripts/cliphist-rofi-img".executable = true;

  xdg.configFile."rofi/themes/rofi-cliphist-theme.rasi".source = ./rofi-cliphist-theme.rasi;

  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "clipboard:${config.xdg.configHome}/rofi/scripts/cliphist-rofi-img";
      show-icons = true;
    };
  };
}
