{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{

  # wayland.windowManager.hyprland.settings.bindm = [
  #   "SUPER, mouse:272, movewindow"
  #   "SUPER, mouse:273, resizewindow"
  # ];

  wayland.windowManager.hyprland.settings.bind =
    let
      # audio
      wpctl = "${pkgs.wireplumber}/bin/wpctl";
      playerctl = "${pkgs.playerctl}/bin/playerctl";

      # user
      brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      applauncher = "${pkgs.fuzzel}/bin/fuzzel";
      term = "${pkgs.foot}/bin/foot";

      kitty = "${pkgs.kitty}/bin/kitty";
      yazi = "${pkgs.yazi}/bin/yazi";

      # utility
      hyprlock = "${pkgs.hyprlock}/bin/hyprlock";

      arr = [
        1
        2
        3
        4
        5
        6
        7
        8
        9
        0
      ];
      lua = lib.generators.mkLuaInline;
      exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
      bind = key: action: {
        _args = [
          key
          (lua action)
        ];
      };
      bindm = key: action: {
        _args = [
          key
          (lua action)
          (lua "{ mouse = true }")
        ];
      };

      movews = ws: ''hl.dsp.focus({ workspace = "${ws}" })'';
      movewd = ws: ''hl.dsp.window.move({ workspace = "${ws}", follow = false })'';
      movewddr = dr: ''hl.dsp.window.move({ direction = "${dr}" })'';
      fs = mode: ''hl.dsp.window.fullscreen({ move = "${mode}" })'';
      focusdr = dr: ''hl.dsp.focus({ direction = "${dr}" })'';
      layout_bind = bind_table_lua: ''
        function ()
            local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
            if not workspace then
                return
            end

            local layout = workspace.tiled_layout
            local bind_table = ${bind_table_lua}
            
            if bind_table[layout] then
                hl.dispatch(bind_table[layout])
            end
        end
      '';
    in

    [
      (bind "SUPER + U" (exec "ghostty"))
      (bind "SUPER + Q" "hl.dsp.window.close()")

      # (bind "SUPER + Y" (exec "[float; size 80% 60%; center] ${kitty} ${yazi}"))

      (bind "SUPER + Y" (
        exec "[float; size 1500 900; center; animation popin 80%] ${kitty} -o remember_window_size=no -o window_padding_width=12 ${yazi}"
      ))

      (bindm "SUPER + mouse:272" "hl.dsp.window.drag()")
      (bindm "SUPER + mouse:273" "hl.dsp.window.resize()")

      (bind "SUPER + mouse_down" "hl.dsp.focus({ workspace = \"m+1\" })")
      (bind "SUPER + mouse_up" "hl.dsp.focus({ workspace = \"m-1\" })")

      (bind "SUPER + ALT + mouse_down" (exec "hyprctl keyword cursor:zoom_factor 1.25"))
      (bind "SUPER + ALT + mouse_up" (exec "hyprctl keyword cursor:zoom_factor 1.0"))

      # (bind "SUPER + ALT + mouse_down" "hl.dsp.cursor_zoom({ mode = \"mult\", zoom_level = \"1.1\" })")
      # (bind "SUPER + ALT + mouse_up" "hl.dsp.cursor_zoom({ mode = \"mult\", zoom_level = \"0.9\" })")

      (bind "SUPER + 1" (movews "1"))
      (bind "SUPER + 2" (movews "2"))
      (bind "SUPER + 3" (movews "3"))
      (bind "SUPER + 4" (movews "4"))
      (bind "SUPER + 5" (movews "5"))
      (bind "SUPER + 6" (movews "6"))
      (bind "SUPER + 7" (movews "7"))
      (bind "SUPER + 8" (movews "8"))
      (bind "SUPER + 9" (movews "9"))
      (bind "SUPER + 0" (movews "0"))

      (bind "SUPER + SHIFT + 1" (movewd "1"))
      (bind "SUPER + SHIFT + 2" (movewd "2"))
      (bind "SUPER + SHIFT + 3" (movewd "3"))
      (bind "SUPER + SHIFT + 4" (movewd "4"))
      (bind "SUPER + SHIFT + 5" (movewd "5"))
      (bind "SUPER + SHIFT + 6" (movewd "6"))
      (bind "SUPER + SHIFT + 7" (movewd "7"))
      (bind "SUPER + SHIFT + 8" (movewd "8"))
      (bind "SUPER + SHIFT + 9" (movewd "9"))
      (bind "SUPER + SHIFT + 0" (movewd "0"))

      (bind "SUPER + H" (focusdr "left"))
      (bind "SUPER + J" (focusdr "down"))
      (bind "SUPER + K" (focusdr "up"))
      (bind "SUPER + L" (focusdr "right"))

      # (bind "SUPER + H" (layout_bind ''
      #   {
      #       scrolling = hl.dsp.exec_cmd("hyprctl dispatch cyclenext prev"),
      #       dwindle   = hl.dsp.focus({ direction = "left" }),
      #       monocle   = hl.dsp.focus({ direction = "left" }),
      #       master    = hl.dsp.focus({ direction = "left" })
      #   }
      # ''))
      #
      # (bind "SUPER + L" (layout_bind ''
      #   {
      #       scrolling = hl.dsp.exec_cmd("hyprctl dispatch cyclenext"),
      #       dwindle   = hl.dsp.focus({ direction = "right" }),
      #       monocle   = hl.dsp.focus({ direction = "right" }),
      #       master    = hl.dsp.focus({ direction = "right" })
      #   }
      # ''))

      (bind "SUPER + SHIFT + L" ''hl.dsp.workspace.move({monitor="r"})'')
      (bind "SUPER + SHIFT + H" ''hl.dsp.workspace.move({monitor="l"})'')

      (bind "ALT + TAB" (exec "noctalia msg window-switcher"))

      (bind "Print" (exec "noctalia msg screenshot-region"))
      (bind "SUPER + Print" (exec "screenshotannotate"))

      (bind "SUPER + F" ''hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" })'')
      (bind "SUPER + SHIFT + F" ''hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" })'')
      # (bind "SUPER + SHIFT + J" "hl.dsp.layout( \"swapprev loop\" )")
      # (bind "SUPER + SHIFT + K" "hl.dsp.layout( \"swapnext loop\" )")

      (bind "SUPER + SHIFT + K" (layout_bind ''
        {
                  scrolling = hl.dsp.layout("swapcol l"),
                  dwindle   = hl.dsp.layout("swapsplit"),
                  monocle   = hl.dsp.layout("cycleprev"),
                  master    = hl.dsp.layout("cycleprev"),
              }''))

      (bind "SUPER + SHIFT + J" (layout_bind ''
        {
                  scrolling = hl.dsp.layout("swapcol r"),
                  dwindle   = hl.dsp.layout("togglesplit"),
                  monocle   = hl.dsp.layout("cyclenext"),
                  master    = hl.dsp.layout("cyclenext"),
              }''))

      # Noctalia
      (bind "SUPER + D" (exec "noctalia msg panel-toggle launcher"))
      (bind "SUPER + B" (exec "noctalia msg panel-toggle clipboard"))

      (bind "SUPER + W" ''hl.dsp.layout("colresize 1.0")'')
      (bind "SUPER + SHIFT + W" ''hl.dsp.layout("colresize 0.5")'')

      (bind "SUPER + SHIFT + TAB" ''
                    function ()
            local layouts     = { "scrolling", "dwindle", "master", "monocle" }
            local workspace   = hl.get_active_workspace()
        	if hl.get_active_special_workspace() then
        		workspace = hl.get_active_special_workspace()
        	end

            local next_layout = "dwindle"

            if not workspace then
                return
            end

            for i = 1, #layouts do
                if layouts[i] == workspace.tiled_layout then
                    local next_layout_idx = (i % #layouts) + 1
                    next_layout = layouts[next_layout_idx]
                    break
                end
            end

        	if workspace.special then
        		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
        	else
        		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
        	end
        end


      '')
    ];
}
