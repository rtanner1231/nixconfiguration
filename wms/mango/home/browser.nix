{ config, pkgs, ... }:

let
  # 1. Define the routing script
  smartBrowser = pkgs.writeShellScriptBin "smart-browser" ''
    URL=$1

    # Check if the URL contains Google Meet
    if [[ "$URL" == *"meet.google.com"* ]]; then
      exec firefox "$URL"
    else
      # If not, pass it to your actual default browser
      # Note: Change "zen" to "zen-browser" if that is your command name
      exec zen-beta "$URL" 
    fi
  '';
in
{
  # Make sure the script is installed
  home.packages = [ smartBrowser ];

  # 2. Create a desktop application entry for the script
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

  # 3. Tell Linux to use the script as the middleman for all web links
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

  # Force overwrite of mimeapps.list to avoid conflicts with existing file
  xdg.configFile."mimeapps.list".force = true;
}
