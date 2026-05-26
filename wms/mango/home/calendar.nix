{ pkgs, config, ... }:
{

  programs.khal = {
    enable = true;
    settings = {
      default = {
        default_calendar = "rtanner@myron.com";
      };
    };
  };
  programs.vdirsyncer.enable = true;
  accounts.calendar.basePath = "${config.xdg.dataHome}/calendars";

  services.vdirsyncer = {
    enable = true;
    frequency = "*:0/15"; # Syncs every 15 minutes
  };

  accounts.calendar.accounts.google = {
    primary = true;

    khal = {
      enable = true;
      type = "discover";
    };

    vdirsyncer = {
      enable = true;
      collections = [
        "from a"
        "from b"
      ];
      conflictResolution = "remote wins";

      # Piggybacking off gcalcli's public, verified OAuth credentials
      clientIdCommand = [
        "echo"
        "406964657835-aq8lmia8j95dhl1a2bvharmfk3t1hgqj.apps.googleusercontent.com"
      ];
      clientSecretCommand = [
        "echo"
        "kSmqreRr0qwBWJgbf5Y-PjSU"
      ];

      tokenFile = "${config.xdg.dataHome}/vdirsyncer/google_token";
    };

    remote = {
      type = "google_calendar";
    };

    local = {
      type = "filesystem";
      fileExt = ".ics";
    };
  };

}
