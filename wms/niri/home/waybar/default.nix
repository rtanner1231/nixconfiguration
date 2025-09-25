{ ... }:
{
  imports = [
    ../../../../common/wayland/waybar
  ];
  programs.waybar.settings.mainBar = {
    modules-left = [
      "niri/workspaces"
    ];
  };
}
