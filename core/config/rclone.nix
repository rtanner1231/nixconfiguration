{
  pkgs,
  profile,
  ...
}:

let
  excludePaths = [
    "/.mozilla/**"
    "/.cache/**"
    "/.zen/**"
    "/.config/slack/**"
    "/.thunderbird/**"
    "/.config/cosmic/**"
  ];
in
{
  environment.systemPackages = with pkgs; [
    rclone
  ];

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
    # Specifies the packages needed in the environment PATH for the command
    path = [ pkgs.rclone ];
    # The actual command to run, using the injected variables
    # Sleep for 30 seconds to give time for DNS to resolve
    script = ''
      set -eu
      sleep 30
      rclone sync "/home/${profile.user}" "GDrive:${profile.name}" \
        ${pkgs.lib.concatMapStringsSep " " (p: "--exclude '${p}'") excludePaths} \
        --log-level INFO
    '';
    # Service configuration details
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = "5m";
    };
  };

  # Define the systemd timer unit to trigger the service
  systemd.user.timers."rclone-backup" = {
    description = "Daily timer for rclone backup";
    wantedBy = [ "timers.target" ]; # Ensures the timer is started on boot
    timerConfig = {
      OnCalendar = "daily";
      # Run once a day
      Persistent = true;
      # Run on next boot if a scheduled start was missed
      Unit = "rclone-backup.service";
      # The service to activate
    };
  };
}
