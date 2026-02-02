{
  ...
}:
{

  programs.niri.settings = {

    layout = {
      gaps = 10;
      "center-focused-column" = "never";

      # (Mod+R)toggles between.
      "preset-column-widths" = [
        { proportion = 0.25; }
        { proportion = 0.5; }
        { proportion = 0.75; }
        { proportion = 1.0; }
      ];
      "preset-window-heights" = [
        { proportion = 0.25; }
        { proportion = 0.5; }
        { proportion = 0.75; }
        { proportion = 1.0; }
      ];
      "default-column-width" = {
        proportion = 0.5;
      };
      "focus-ring" = {
        enable = true;
        width = 2;
        active = {
          color = "#7aa2f7";
        };
      };
      border = {
        width = 1.5;
        active = {
          color = "#0313fc";
        };
        inactive = {
          color = "#7a8570";
        };
        urgent = {
          color = "#9b0000";
        };
      };
      #shadow = {
      #   on = true;
      #   "draw-behind-window" = true;
      #   softness = 0;
      #   spread = 1;
      #   offset = { x = 1; y = 1; };
      #   color = "#2d3228";
      #   "inactive-color" = "#2d3228";
      # };
    };

  };

}
