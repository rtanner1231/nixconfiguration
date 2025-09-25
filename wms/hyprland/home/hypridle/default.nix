{ pkgs, ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      };

      listener = {
        timeout = 300;
        on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";

      };
    };
  };

}
