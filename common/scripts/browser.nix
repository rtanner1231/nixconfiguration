{ config, pkgs, ... }:

let
  smartBrowser = pkgs.writeShellScriptBin "smart-browser" ''
    URL=$1

    if [[ "$URL" == *"meet.google.com"* ]]; then
      exec firefox "$URL"
    else
      exec zen-beta "$URL"
    fi
  '';
in
{
  home.packages = [ smartBrowser ];

  # Force system environment variables to point to your script
  home.sessionVariables = {
    BROWSER = "smart-browser";
  };

  xdg.desktopEntries.smart-browser = {
    name = "Smart Browser Router";
    exec = "${smartBrowser}/bin/smart-browser %U";
    terminal = false;
    type = "Application";
    mimeType = [
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "smart-browser.desktop";
      "x-scheme-handler/http" = "smart-browser.desktop";
      "x-scheme-handler/https" = "smart-browser.desktop";
      "x-scheme-handler/about" = "smart-browser.desktop";
      "x-scheme-handler/unknown" = "smart-browser.desktop";
    };
  };

  xdg.configFile."mimeapps.list".force = true;
}
