{ pkgs, ... }:

let
  # Router script to inspect URLs
  browserRouter = pkgs.writeShellScriptBin "browser-router" ''
    URL="$1"

    # Fallback to default if no argument is passed
    if [ -z "$URL" ]; then
      exec zen-beta
    fi

    # Check if the URL contains meet.google.com
    if [[ "$URL" == *"meet.google.com"* ]]; then
      exec ${pkgs.firefox}/bin/firefox "$URL"
    else
      # Update 'zen' if your Zen browser binary uses a different command name
      exec zen-beta "$URL"
    fi
  '';

  # Desktop file to register the router as an application
  browserRouterDesktop = pkgs.makeDesktopItem {
    name = "browser-router";
    desktopName = "Browser Router";
    exec = "${browserRouter}/bin/browser-router %U";
    terminal = false;
    mimeTypes = [
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "text/html"
    ];
  };
in
{
  home.packages = [
    browserRouter
    browserRouterDesktop
  ];

  # Set the script as the system default browser handler
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "browser-router.desktop";
      "x-scheme-handler/http" = "browser-router.desktop";
      "x-scheme-handler/https" = "browser-router.desktop";
      "x-scheme-handler/about" = "browser-router.desktop";
      "x-scheme-handler/unknown" = "browser-router.desktop";
    };
  };
}
