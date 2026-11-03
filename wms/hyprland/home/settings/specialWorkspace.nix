{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  bind = key: action: {
    _args = [
      key
      (lua action)
    ];
  };
  lazySpecialToggle = name: command: ''
    function()
      if #hl.get_workspace_windows("special:${name}") == 0 then
        hl.exec_cmd("[workspace special:${name} silent] ${command}")
      end
      hl.dispatch(hl.dsp.workspace.toggle_special("${name}"))
    end
  '';
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      (bind "SUPER + CTRL + O" (lazySpecialToggle "obsidian" "obsidian"))
      (bind "SUPER + CTRL + A" (lazySpecialToggle "opencode" "opencode-desktop"))
      (bind "SUPER + CTRL + T" (lazySpecialToggle "thunderbird" "thunderbird"))
      (bind "SUPER + CTRL + F" (lazySpecialToggle "firefox" "firefox"))
      (bind "SUPER + CTRL + B" (lazySpecialToggle "bruno" "bruno"))
      (bind "SUPER + CTRL + C" (lazySpecialToggle "gchat" "google-chat-linux"))
    ];
  };
}
