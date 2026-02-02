{
  ...
}:
{

  programs.niri.settings = {

    "spawn-at-startup" = [
      { argv = [ "snixembed" ]; }
      #{ argv = [ "waybar" ]; }
      # { argv = [ "thunderbird" ]; }
      # { argv = [ "slack" ]; }
      {
        argv = [ "noctalia-shell" ];
      }
      {
        argv = [
          "wayscriber"
          "--daemon"
        ];
      }
      # { argv = [ "swww-daemon" ]; }
      # { argv = [ "swww", "img", "~/.mine/dots/wallpapers/1.png" ]; } # Example of command with args
      # { argv = [ "systemctl", "--user", "start", "hyprpolkitagent" ]; }
    ];

  };

}
