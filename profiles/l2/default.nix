{ wm, profile, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../core/config
    ./home
    ../../wms/${wm}
  ];

  zramSwap = {
     enable=true;
     algorithm="zstd";
     memoryPercent=50;
  };

  services.earlyoom = {
     enable=true;
     freeMemThreshold = 5;
     freeSwapThreshold = 10;
  };

  rclonebackup = {
    enable = false;
    remoteName = "GDrive";
    remotePath = profile.name;
    excludedPaths = [
      "/.mozilla/**"
      "/.cache/**"
      "/.zen/**"
      "/.config/slack/**"
      "/.thunderbird/**"
      "/.config/cosmic/**"
      "/.bun/**"
    ];
  };
}
