{ config, pkgs, ... }:

{
  # Enable the Hyprlock program
  programs.hyprlock = {
    enable = true;
    # Recommended for better screenshot performance
    #package = pkgs.hyprlock.override { withNixBuiltins = true; };

    # Main settings for the lock screen's appearance and behavior
    settings = {
      # GENERAL
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 10; # Seconds before locking after screen dims
      };

      # BACKGROUND
      background = [
        {
          # Use a screenshot of the current screen as the background
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          vibrancy = 0.169;
          vibrancy_darkness = 0.0;
        }
      ];

      # INPUT FIELD
      input-field = [
        {
          size = "250, 50";
          position = "0, -80";
          halign = "center";
          valign = "center";

          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          inner_color = "rgba(24, 24, 38, 0.8)"; # Surface0
          outer_color = "rgba(137, 180, 250, 1.0)"; # Blue
          font_color = "rgba(205, 214, 244, 1.0)"; # Text
          fade_on_empty = false;
          placeholder_text = "<i>Password...</i>";
          rounding = 12;
        }
      ];

      # TIME
      time = [
        {
          position = "0, 80";
          halign = "center";
          valign = "center";
          font_size = 100;
          font_family = "fira-code";
          color = "rgba(205, 214, 244, 1.0)"; # Text
        }
      ];

      # DATE (as a custom label)
      label = [
        {
          text = "cmd[date +'%A, %B %d']";
          position = "0, 30";
          halign = "center";
          valign = "center";
          font_size = 25;
          font_family = "fira-code";
          color = "rgba(205, 214, 244, 1.0)"; # Text
        }
        {
          text = "Hi, $USER";
          position = "0, -150";
          halign = "center";
          valign = "center";
          font_size = 20;
          font_family = "fira-code";
          color = "rgba(205, 214, 244, 1.0)"; # Text
        }
      ];
    };
  };
}
