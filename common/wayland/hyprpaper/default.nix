{ ... }:
{
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [
        "~/Pictures/Wallpaper/wallpaper.jpg"
      ];

      wallpaper = [
        ",~/Pictures/Wallpaper/wallpaper.jpg"
      ];

      splash = false;

    };
  };
}
