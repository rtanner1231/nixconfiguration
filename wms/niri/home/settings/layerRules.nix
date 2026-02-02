{
  ...
}:
{

  programs.niri.settings = {

    "layer-rules" = [
      {
        matches = [
          { namespace = "^noctalia-overview*"; }
        ];
        place-within-backdrop = true;
      }
      # {
      #     # matches = [
      #     #   { namespace = "waybar"; }
      #     #   { "at-startup" = true; }
      #     # ];
      #     shadow = {
      #       enable = true; # Was 'on'
      #       "draw-behind-window" = true;
      #       softness = 0;
      #       spread = 0.5;
      #       offset = {
      #         x = 0.5;
      #         y = 0.5;
      #       };
      #       color = "#2d3228";
      #       "inactive-color" = "#2d3228";
      #     };
      #   }
      #   {
      #     matches = [
      #       { namespace = "^launcher$"; }
      #     ];
      #     shadow = {
      #       enable = true; # Was 'on'
      #       "draw-behind-window" = true;
      #       softness = 0;
      #       spread = 1;
      #       offset = {
      #         x = 1;
      #         y = 1;
      #       };
      #       color = "#2d3228";
      #       "inactive-color" = "#2d3228";
      #     };
      #   }
    ];

  };

}
