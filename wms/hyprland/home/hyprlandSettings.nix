{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    kitty # Terminal
    waybar # Status bar
    swaybg # Wallpaper
    rofi # App launcher
    swaynotificationcenter # Notification daemon
    swaylock # Screen locker
    kdePackages.dolphin
  ];

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Basic settings and keybindings
      "$mod" = "SUPER";
      exec-once = [
        "waybar"
        "swaybg -i /path/to/your/wallpaper.png" # Change this path

        "exec-once = [ workspace special:thunderbird silent ] thunderbird"
      ];

      monitor = ",preferred,auto,1";

      input = {
        kb_layout = "us";
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgb(cdd6f4)";
        "col.inactive_border" = "rgb(1e1e2e)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur.enabled = true;
        blur.size = 3;
        blur.passes = 1;
      };

      # Keybindings
      bind = [
        "$mod, RETURN, exec, ghostty"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, E, exec, dolphin" # Example file manager
        "$mod, D, exec, rofi-launcher"
        "$mod, L, exec, swaylock"
        "$mod, P, exec, ~/scripts/rofiprojects.sh"

        # Move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Switch workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Move workspace to the left/right monitor with ctrl + super + <>
        "$mod CTRL, COMMA, movecurrentworkspacetomonitor, l"
        "$mod CTRL, PERIOD, movecurrentworkspacetomonitor, r"

        #special workspaces
        "$mod, T, togglespecialworkspace, thunderbird"

      ];
    };
  };

}
