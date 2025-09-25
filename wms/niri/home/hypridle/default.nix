{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "${pkgs.niri}/bin/niri msg action power-on-monitors";
      };

      listener = {
        timeout = 300;
        on-timeout = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        on-resume = "${pkgs.niri}/bin/niri msg action power-on-monitors";

      };
    };
  };

}
