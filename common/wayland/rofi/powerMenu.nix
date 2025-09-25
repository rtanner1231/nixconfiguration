# In your home.nix or a file imported by it

{ pkgs, ... }:

let
  # The final, robust theme.
  powerMenuTheme = pkgs.writeText "rofi-power-theme.rasi" ''
    * {
      background-color: transparent;
      text-color:       #F8F8F2;
      font:             "FiraCode Nerd Font 12";
    }

    window {
      width:      700px;
      padding:    20px; /* Padding for the outer window */
      border:     2px;
      border-radius: 12px;
      border-color: #BD93F9;
      background-color: #282A36F0;
    }

    mainbox {
      /* No special properties needed here */
    }

    listview {
      /* The listview is now fully in charge of the layout */
      fixed-columns:  true;
      columns:        5;
      spacing:        20px; /* This creates a 20px gap BETWEEN each element */
      layout:         horizontal;
    }

    element {
      /* The element now has NO margin or width. It just fills its column. */
      width: 110px;
      orientation:    vertical;
      padding:        25px; /* Padding INSIDE each button */
      border:         2px;
      border-radius:  10px;
      border-color:   #44475A;
    }

    element-text {
      font:             "FiraCode Nerd Font 36";
      background-color: inherit;
      text-color:       inherit;
      horizontal-align: 0.5;
      vertical-align:   0.5;
    }

    element selected {
      background-color: #44475A;
      border-color:     #BD93F9;
    }

    inputbar {
      enabled: false;
    }
  '';

  # The script does not need any changes.
  rofi-powermenu = pkgs.writeShellScriptBin "rofi-powermenu" ''
    #! /usr/bin/env bash

    shutdown=""
    reboot=""
    lock=""
    suspend=""
    logout="󰗼"

    chosen=$(echo -e "$shutdown\n$reboot\n$suspend\n$lock\n$logout" | rofi -dmenu -i -theme ${powerMenuTheme})

    case "$chosen" in
        "$shutdown")
            systemctl poweroff
            ;;
        "$reboot")
            systemctl reboot
            ;;
        "$suspend")
            systemctl suspend
            ;;
        "$lock")
            hyprlock
            ;;
        "$logout")
            niri msg action quit
            ;;
    esac
  '';

in
{
  programs.rofi.enable = true;

  home.packages = [
    rofi-powermenu
  ];
}
