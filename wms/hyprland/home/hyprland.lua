local mod = "SUPER"

hl.monitor = {",preferred,auto,1"}

hl.exec_once = {
    "noctalia",
    "swaybg -i /path/to/your/wallpaper.png",
    "[workspace special:thunderbird silent] thunderbird"
}

hl.input = {
    kb_layout = "us"
}

hl.general = {
    gaps_in = 5,
    gaps_out = 20,
    border_size = 2,
    ["col.active_border"] = "rgb(cdd6f4)",
    ["col.inactive_border"] = "rgb(1e1e2e)",
    layout = "dwindle"
}

hl.decoration = {
    rounding = 10,
    blur = {
        enabled = true,
        size = 3,
        passes = 1
    }
}

hl.bind = {
    {mod, "RETURN", "exec", "ghostty"},
    {mod, "Q", "killactive"},
    {mod, "M", "exit"},
    {mod, "E", "exec", "dolphin"},
    {mod, "D", "exec", "rofi-launcher"},
    {mod .. " CTRL", "P", "exec", "rofi-switchwm"},
    {mod, "P", "exec", "~/scripts/rofiprojects.sh"},
    {mod, "left", "movefocus", "l"},
    {mod, "right", "movefocus", "r"},
    {mod, "up", "movefocus", "u"},
    {mod, "down", "movefocus", "d"},
    {mod, "1", "workspace", "1"},
    {mod, "2", "workspace", "2"},
    {mod, "3", "workspace", "3"},
    {mod, "4", "workspace", "4"},
    {mod, "5", "workspace", "5"},
    {mod, "6", "workspace", "6"},
    {mod, "7", "workspace", "7"},
    {mod, "8", "workspace", "8"},
    {mod, "9", "workspace", "9"},
    {mod, "0", "workspace", "10"},
    {mod .. " SHIFT", "1", "movetoworkspace", "1"},
    {mod .. " SHIFT", "2", "movetoworkspace", "2"},
    {mod .. " SHIFT", "3", "movetoworkspace", "3"},
    {mod .. " SHIFT", "4", "movetoworkspace", "4"},
    {mod .. " SHIFT", "5", "movetoworkspace", "5"},
    {mod .. " SHIFT", "6", "movetoworkspace", "6"},
    {mod .. " SHIFT", "7", "movetoworkspace", "7"},
    {mod .. " SHIFT", "8", "movetoworkspace", "8"},
    {mod .. " SHIFT", "9", "movetoworkspace", "9"},
    {mod .. " SHIFT", "0", "movetoworkspace", "10"},
    {mod .. " CTRL", "COMMA", "movecurrentworkspacetomonitor", "l"},
    {mod .. " CTRL", "PERIOD", "movecurrentworkspacetomonitor", "r"},
    {mod, "T", "togglespecialworkspace", "thunderbird"},
    {mod .. " CTRL", "Z", "exec", "rofi-powermenu"}
}
