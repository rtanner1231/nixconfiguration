# In your home.nix or a file imported by it
{ pkgs, ... }:

let
  # A theme for the window manager switcher, adapted from your launcher.nix.
  wmSwitcherTheme = pkgs.writeText "rofi-wm-switcher-theme.rasi" ''
    /*****----- Global Properties -----*****/
    * {
        /* Colors */
        background:                 #262626;
        background-alt:             #353535;
        foreground:                 #D8D8D8;
        selected:                   #FFFFFF;
        active:                     #87A181;

        /* Font */
        font:                       "Fira Code 10";

        border-colour:              var(selected);
        handle-colour:              var(selected);
        background-colour:          var(background);
        foreground-colour:          var(foreground);
        alternate-background:       var(background-alt);
        normal-background:          var(background);
        normal-foreground:          var(foreground);
        active-background:          var(active);
        active-foreground:          var(background);
        selected-normal-background: var(selected);
        selected-normal-foreground: var(background);
    }

    /*****----- Main Window -----*****/
    window {
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       600px;
        border:                      1px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            @background-colour;
    }

    /*****----- Main Box -----*****/
    mainbox {
        spacing:                     10px;
        padding:                     20px;
        background-color:            transparent;
        children:                    [ "inputbar", "message", "listview" ];
    }

    /*****----- Inputbar -----*****/
    inputbar {
        spacing:                     10px;
        padding:                     0px 0px 8px 0px;
        border:                      0px 0px 1px 0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        children:                    [ "prompt", "entry" ];
    }

    prompt {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
    }
    entry {
        background-color:            inherit;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "Confirm...";
        placeholder-color:           inherit;
    }

    /*****----- Listview -----*****/
    listview {
        columns:                     1;
        lines:                       4; /* Adjusted for 4 WM options */
        cycle:                       true;
        scrollbar:                   false;
        layout:                      vertical;
        spacing:                     5px;
        padding:                     8px 0px 0px 0px;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }

    /*****----- Elements -----*****/
    element {
        padding:                     8px;
        border-radius:               0px;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        cursor:                      pointer;
    }
    element normal.normal {
        background-color:            var(normal-background);
        text-color:                  var(normal-foreground);
    }
    element selected.normal {
        background-color:            var(selected-normal-background);
        text-color:                  var(selected-normal-foreground);
    }
    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        highlight:                   inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0; /* Left-aligned text */
    }

    /*****----- Message -----*****/
    message {
        padding:                     8px 12px;
        border:                      0px solid;
        border-radius:               0px;
        background-color:            @alternate-background;
        text-color:                  @foreground-colour;
    }
    textbox {
        background-color:            transparent;
        text-color:                  @foreground-colour;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }
  '';

  # The script to switch window managers
  rofi-switchwm-script = pkgs.writeShellScriptBin "rofi-switchwm" ''
    #! /usr/bin/env bash

    set -e # Exit immediately if a command exits with a non-zero status.

    # Check if NIXPROFILE is set
    if [ -z "$NIXPROFILE" ]; then
        rofi -e "The NIXPROFILE environment variable is not set."
        exit 1
    fi

    # Define all Window Manager options
    all_wms="GNOME\nKDE\nCinnamon\nHyprland\nNiri"

    # Filter out the current WM if NIXWM is set
    if [ -n "$NIXWM" ]; then
        menu_options=$(echo -e "$all_wms" | grep -iv "^$NIXWM$")
    else
        menu_options=$(echo -e "$all_wms")
    fi

    # Display Rofi menu
    chosen=$(echo -e "$menu_options" | rofi -dmenu -i -p "Switch WM" -theme ${wmSwitcherTheme})

    # Variable to hold the final flake target
    flake_target=""

    # Determine the flake target based on user's choice
    case "$chosen" in
        "GNOME")
            flake_target="gnome"
            ;;
        "KDE")
            flake_target="kde"
            ;;
        "Cinnamon")
            flake_target="cinnamon"
            ;;
        "Hyprland")
            flake_target="hyprland"
            ;;
        "Niri")
            flake_target="niri"
            ;;
        *)
            # Exit if no option is chosen (e.g., user presses Esc)
            exit 0
            ;;
    esac

    # Construct the full flake reference
    full_flake_ref=".#''${NIXPROFILE}-''${flake_target}"

    # Confirmation dialog
    rofi -dmenu \
         -i -p "Rebuild to $full_flake_ref and reboot?" \
         -mesg "Type 'yes' to confirm" \
         -theme ${wmSwitcherTheme} | grep -q "yes" || exit 0


    # This is the script that will run inside the new terminal.
    # We use single quotes to prevent this script's contents from being interpreted
    # by the current shell.
    rebuild_script='
      set -e
      # The first argument from the outer command ($1) is our flake reference.
      FLAKE_REF="$1"

      echo "--- Starting NixOS rebuild for: $FLAKE_REF"
      echo "--------------------------------------------------"

      # The $HOME variable is available in the new shell environment.
      sudo nixos-rebuild switch --flake "$HOME/nixconfiguration/$FLAKE_REF"

      echo "--------------------------------------------------"
      echo "--- Rebuild successful. Rebooting in 5 seconds..."
      sleep 5
      sudo reboot

      echo "--- If reboot does not happen, please close this window."
      sleep 10
    '

    # Execute the rebuild script inside a terminal.
    # IMPORTANT: You can replace 'ghostty' with your preferred terminal emulator (e.g., kitty, alacritty).
    # Most terminals use a flag like `-e` to execute a command.
    # We pass the script to `bash -c`.
    # 'bash' becomes the name of the script ($0).
    # "$full_flake_ref" becomes the first argument ($1).
    ghostty --title="NixOS Rebuild" -e bash -c "$rebuild_script" bash "$full_flake_ref"
  '';

in
{
  # Enable Rofi for your user
  programs.rofi.enable = true;

  # Add the script to your user's PATH
  home.packages = [
    rofi-switchwm-script
  ];
}
