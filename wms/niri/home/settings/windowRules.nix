{
  ...
}:
{

  programs.niri.settings = {

    "window-rules" = [
      #   # {
      #   #   matches = [
      #   #     {
      #   #       "at-startup" = true;
      #   #       "app-id" = "r#\"thunderbird\"#";
      #   #     }
      #   #     {
      #   #       "at-startup" = true;
      #   #       "app-id" = "r#\"Slack\"#";
      #   #     }
      #   #   ];
      #   #   "open-on-workspace" = "media";
      #   #   "open-maximized" = true;
      #   # }
      #   {
      #     matches = [
      #       { "app-id" = "r#\"^org\\.wezfurlong\\.wezterm$\"#"; }
      #     ];
      #     "default-column-width" = { };
      #   }
      #   {
      #     matches = [
      #       {
      #         "app-id" = "r#\"firefox$\"#";
      #         title = "^Picture-in-Picture$";
      #       }
      #     ];
      #     "open-floating" = true;
      #   }
      {
        matches = [ ]; # Applies to all windows
        "geometry-corner-radius" = {
          "top-left" = 12.0;
          "top-right" = 12.0;
          "bottom-right" = 12.0;
          "bottom-left" = 12.0;
        };
        "clip-to-geometry" = true;
      }
      {
        matches = [
          {
            "is-focused" = true;
            "app-id" = "com.mitchellh.ghostty";
          }
        ];
        opacity = 0.9;
      }
      {
        matches = [
          {
            "is-focused" = false;
            "app-id" = "com.mitchellh.ghostty";
          }
        ];
        opacity = 0.7;
      }
    ];

  };

}
