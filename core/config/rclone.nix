{
  config,
  lib,
  pkgs,
  profile,
  ...
}:

let
  cfg = config.rclonebackup;
in
{
  options.rclonebackup = {
    enable = lib.mkEnableOption "Enable the rclone backup service";

    remoteName = lib.mkOption {
      type = lib.types.str;
      description = "The name of the rclone remote to use for the backup.";
      example = "GDrive";
    };

    remotePath = lib.mkOption {
      type = lib.types.str;
      description = "The path on the remote to sync to.";
      example = "nixos-backup";
    };

    excludedPaths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "A list of paths to exclude from the backup, relative to the user's home directory.";
      example = ''
        [
          "/.cache/**"
          "/.mozilla/**"
        ]
      '';
    };
  };

  # The configuration is only applied if the `enable` option is set to true.
  config = lib.mkIf cfg.enable {
    # Install rclone system-wide.
    environment.systemPackages = with pkgs; [
      rclone
    ];

    # Define the systemd service to run the backup.
    systemd.user.services."rclone-backup" = {
      description = "Rclone backup service";
      after = [
        "network-online.target"
        "systemd-resolved.service"
      ];
      wants = [
        "network-online.target"
        "systemd-resolved.service"
      ];
      # Specifies the packages needed in the environment PATH for the command.
      path = [ pkgs.rclone ];
      # The actual command to run, using the values from the options.
      script = ''
        set -eu
        # Sleep for 30 seconds to give time for DNS to resolve.
        sleep 30
        rclone sync "/home/${profile.user}" "${cfg.remoteName}:${cfg.remotePath}" \
          ${pkgs.lib.concatMapStringsSep " " (p: "--exclude '${p}'") cfg.excludedPaths} \
          --log-level INFO
      '';
      # Service configuration details.
      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = "5m";
      };
    };

    # Define the systemd timer to trigger the service daily.
    systemd.user.timers."rclone-backup" = {
      description = "Daily timer for rclone backup";
      # Ensures the timer is started on boot.
      wantedBy = [ "timers.target" ];
      timerConfig = {
        # Run once a day.
        OnCalendar = "daily";
        # Run on next boot if a scheduled start was missed.
        Persistent = true;
        # The service to activate.
        Unit = "rclone-backup.service";
      };
    };
  };
}
