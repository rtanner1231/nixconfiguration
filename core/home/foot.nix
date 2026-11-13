{ pkgs, ... }:

{
  programs.foot = {
    enable = true;

    # Runs foot in client/server daemon mode to share memory across windows
    server.enable = true;

    settings = {
      main = {
        # 1. Adjust font and scale:
        # Default is monospace:size=8. Increasing size to 11–13 fixes the "zoomed out" look.
        font = "monospace:size=12";

        # Optional: Add fallback fonts for nerd icons/emojis
        # font = "JetBrainsMono Nerd Font:size=11, Noto Color Emoji:size=11";

        # DPI handling:
        # "yes" sizes via physical monitor DPI (~157 DPI on this panel, which makes fonts ~1.6x larger).
        # "no" (foot's default) scales according to the Wayland compositor's scale factor (96 DPI base).
        dpi-aware = "no";

        # Window padding (Horizontal x Vertical in pixels)
        pad = "8x8";
      };

      scrollback = {
        # Default is 1,000 lines. 5,000 to 10,000 is generous without consuming much RAM.
        lines = 5000;
      };

      cursor = {
        style = "beam";
        blink = false; # Disabling blink slightly reduces wakeups/power draw
      };

      mouse = {
        # Automatically hides the mouse cursor while typing
        hide-when-typing = "yes";
      };

      url = {
        # Allows opening URLs in URL mode
        launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
      };

      colors-dark = {
        # Opacity (1.0 = solid opaque, lowest memory overhead)
        alpha = 1.0;
      };
    };
  };
}
