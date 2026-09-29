{ ... }:
{
  wayland.windowManager.hyprland.settings =
    let
      float = className: {
        match = {
          class = className;
        };
        float = true;
      };
    in
    {
      window_rule = [
        (float "com\\.gabm\\.satty")
      ];
    };
}
