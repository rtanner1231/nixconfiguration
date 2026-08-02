{
  config,
  pkgs,
  lib,
  ...
}:
let
  lua = lib.generators.mkLuaInline;
  on = event: body: {
    _args = [
      event
      (lua "function() ${body} end")
    ];
  };
  exec = cmd: ''hl.exec_cmd("${cmd}")'';
in

{
  wayland.windowManager.hyprland.settings = {
    on = [
      (on "hyprland.start" ''
        ${exec "noctalia"}
      '')
    ];
  };
}
