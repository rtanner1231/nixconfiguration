{ lib, ... }:
{
  wayland.windowManager.hyprland.settings =
    let
      lua = lib.generators.mkLuaInline;
      on = event: body: {
        _args = [
          event
          (lua "function() ${body} end")
        ];
      };
      exec = cmd: ''hl.exec_cmd("${cmd}")'';
      specialWorkspace = name: command: (exec "[workspace special:${name} silent] ${command}");
      onSpecialWorkspace = name: command: (on "hyprland.start" "${specialWorkspace name command}");
      bind = key: action: {
        _args = [
          key
          (lua action)
        ];
      };
      special-toggle = name: ''hl.dsp.workspace.toggle_special "${name}"'';

    in
    {
      on = [
        (onSpecialWorkspace "obsidian" "obsidian")
        (onSpecialWorkspace "opencode" "opencode-desktop")
        (onSpecialWorkspace "thunderbird" "thunderbird")
        (onSpecialWorkspace "firefox" "firefox")
        (onSpecialWorkspace "bruno" "bruno")
      ];

      bind = [
        (bind "SUPER + CTRL + O" (special-toggle "obsidian"))
        (bind "SUPER + CTRL + A" (special-toggle "opencode"))
        (bind "SUPER + CTRL + T" (special-toggle "thunderbird"))
        (bind "SUPER + CTRL + F" (special-toggle "firefox"))
        (bind "SUPER + CTRL + B" (special-toggle "bruno"))
      ];
    };
}
