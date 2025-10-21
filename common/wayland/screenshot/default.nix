{
  pkgs,
  lib,
  ...
}:

with lib;

let

  slurpCmd = "${pkgs.slurp}/bin/slurp -d -b 00000080";

  # Script 1: screenshotcopy
  # Takes a screenshot of a selected region, copies it to the
  # clipboard, and sends a notification.
  screenshotcopy = pkgs.writeShellScriptBin "screenshotcopy" ''
    #!${pkgs.runtimeShell}

    # Get geometry from slurp
    # The -d flag dims the screen
    geom=$(${slurpCmd})

    # Exit if slurp was cancelled (e.g., by pressing Esc)
    if [ -z "$geom" ]; then
      exit 0
    fi

    # Take screenshot of the selected geometry ('-g "$geom"')
    # and pipe the raw image data ('-') to wl-copy.
    ${pkgs.grim}/bin/grim -g "$geom" - | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png

    # Send a notification
    ${pkgs.libnotify}/bin/notify-send -a "Screenshot" "Screenshot Copied" "Region captured to clipboard."
  '';

  # Script 2: screenshotannotate
  # Takes a screenshot of a selected region, saves it to a
  # temp file, and opens it in satty for annotation.
  screenshotannotate = pkgs.writeShellScriptBin "screenshotannotate" ''
    #!${pkgs.runtimeShell}

    # Create a temporary file for the screenshot
    tmpfile=$(${pkgs.coreutils}/bin/mktemp /tmp/screenshot-XXXXXX.png)

    # Get geometry from slurp
    geom=$(${slurpCmd})

    # Exit and clean up if slurp was cancelled
    if [ -z "$geom" ]; then
      ${pkgs.coreutils}/bin/rm "$tmpfile"
      exit 0
    fi

    # Take screenshot and save it to the temp file
    ${pkgs.grim}/bin/grim -g "$geom" "$tmpfile"

    # Open the screenshot in satty
    ${pkgs.satty}/bin/satty --filename "$tmpfile"

    # Clean up the temp file after satty is closed
    ${pkgs.coreutils}/bin/rm "$tmpfile"
  '';

in
{
  # Add all necessary packages to the user's profile
  home.packages = with pkgs; [
    # The scripts
    screenshotcopy
    screenshotannotate

    # The dependencies
    grim # The screenshot tool
    slurp # The region selection tool
    wl-clipboard # For copying to the clipboard
    satty # The annotation tool
    libnotify # For sending notifications
    coreutils # For mktemp and rm
  ];
}
