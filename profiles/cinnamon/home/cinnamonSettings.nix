{ pkgs, ... }:
{

  gtk = {
    enable = true;
    theme = {
      name = "Mint-Y-Dark-Aqua";
      package = pkgs.mint-themes;
    };
    iconTheme = {
      name = "Mint-Y-Aqua";
      package = pkgs.mint-themes;
    };
    font = {
      name = "Noto Sans";
      size = 10;
    };
  };

  # 3. Advanced Configuration via dconf
  # Example of setting an application-specific option declaratively.
  # This sets the terminal used by Nemo's "Open in Terminal" feature.
  dconf.settings = {
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "ghostty";
    };
  };

  # 4. Declarative Default Applications (XDG MIME Associations)
  # Example of setting the default web browser for the system.
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };
}
