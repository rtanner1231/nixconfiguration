{ ... }:
{
  imports = [
    ../../../../common/wayland/waybar
  ];
  programs.waybar.settings.mainBar = {
    modules-left = [
      "hyprland/workspaces"
    ];
  };
}
