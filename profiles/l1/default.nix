{ wm, profile, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../core/config
    ./home
    ../../wms/${wm}
  ];

  #rclonebackup = {
  #  enable = true;
  #  remoteName = "GDrive";
  #  remotePath = profile.name;
  #  excludedPaths = [
  #    "/.mozilla/**"
  #    "/.cache/**"
  #    "/.zen/**"
  #    "/.config/slack/**"
  #    "/.thunderbird/**"
  #    "/.config/cosmic/**"
  #    "/.bun/**"
  #  ];
  #};
}
