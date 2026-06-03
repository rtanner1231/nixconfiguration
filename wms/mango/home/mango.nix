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
    # extraConfig = builtins.readFile ./config.conf;
    extraConfig = ''
      ${builtins.readFile ./settings/general.conf}
      ${builtins.readFile ./settings/appearance.conf}
      ${builtins.readFile ./settings/layouts.conf}
      ${builtins.readFile ./settings/bindings.conf}
      ${builtins.readFile ./settings/rules.conf}
    '';
  };

  # Keep your GTK settings alongside it
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "color-scheme" = "prefer-dark";
    };
  };
}
