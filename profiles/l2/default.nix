{
  wm,
  profile,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../core/config
    ./home
    ../../wms/${wm}
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  boot.tmp.useTmpfs = false;

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
    "vm.vfs_cache_pressure" = 150;
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 10;
  };

  services.printing.enable = lib.mkForce false;

  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "3G";
    MemoryMax = "4G";
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
