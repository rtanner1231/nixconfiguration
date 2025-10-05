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
  ];
in
{
  environment.systemPackages = with pkgs; [
    rclone
  ];
  # Define the systemd service unit
  systemd.services."rclone-backup" = {
    description = "Rclone backup for user ${profile.user}";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    # Specifies the packages needed in the environment PATH for the command
    path = [ pkgs.rclone ];
    # The actual command to run, using the injected variables
    script = ''
      set -eu
      rclone sync "/home/${profile.user}" "GDrive:${profile.name}" \
        ${pkgs.lib.concatMapStringsSep " " (p: "--exclude '${p}'") excludePaths} \
        --log-level INFO
    '';
    # Service configuration details
    serviceConfig = {
      Type = "oneshot";
      # The service runs a command once and then exits
      User = profile.user;
      Group = "users";
    };
  };

  # Define the systemd timer unit to trigger the service
  systemd.timers."rclone-backup" = {
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
