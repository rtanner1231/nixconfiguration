{ pkgs, inputs, ... }:
{
  wayland.windowManager.mango = {
    enable = true;

    # Mango expects autostart scripts as a raw shell string
    # Note: No need to add a shebang here
    autostart_sh = ''
      snixembed &
      dms run --daemon &
      wayscriber --daemon &
    '';

    # Mango expects the configuration as a raw string matching config.conf
    settings = builtins.readFile ./config.conf;
  };

  # Keep your GTK settings alongside it
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };
}
