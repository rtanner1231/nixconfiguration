{ pkgs, inputs, ... }:
let
  calendarPlugin = inputs.noctalia-calendar.packages.${pkgs.system}.default;
in
{
  # import the home manager module
  imports = [
    inputs.noctalia.homeModules.default
  ];
  systemd.user.services.noctalia.Service.Environment = [
    "QT_NO_XDG_DESKTOP_PORTAL=1"
  ];

  # xdg.configFile."noctalia/plugins/next-event".source =
  #   inputs.next-event.packages.${pkgs.system}.default;

  home.packages = [ calendarPlugin ];

  xdg.configFile."noctalia/plugins/noctalia-calendar".source =
    "${calendarPlugin}/share/noctalia/plugins/noctalia-calendar";

  # systemd.user.services.noctalia = {
  #   Unit = {
  #     Description = "Noctalia Shell";
  #     # Only start if the graphical session is up
  #     PartOf = [ "graphical-session.target" ];
  #     After = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     # Adjust "noctalia-shell" if your package name is different
  #     # We use 'qs' (quickshell) to launch it
  #     ExecStart = "${pkgs.quickshell}/bin/qs -c ${inputs.noctalia}";
  #     Restart = "on-failure";
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };

  # configure options
  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 41;
      bar = {
        showCapsule = false;
        widgets = {
          left = [
            {
              colorizeIcons = false;
              hideMode = "hidden";
              iconScale = 0.8;
              id = "Taskbar";
              maxTaskbarWidth = 30;
              onlyActiveWorkspaces = false;
              onlySameOutput = false;
              showPinnedApps = true;
              showTitle = false;
              smartWidth = true;
              titleWidth = 120;
            }
          ];
          center = [
            {
              characterCount = 2;
              colorizeIcons = false;
              enableScrollWheel = true;
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = false;
              iconScale = 0.8;
              id = "Workspace";
              labelMode = "index";
              showApplications = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
            }
          ];
          right = [
            {
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              id = "NotificationHistory";
              showUnreadBadge = true;
            }
            {
              deviceNativePath = "";
              displayMode = "onhover";
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
              warningThreshold = 30;
            }
            {
              displayMode = "onhover";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
            }
            {
              id = "KeepAwake";
            }
            {
              blacklist = [ ];
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [ ];
            }
            {
              displayMode = "onhover";
              id = "Network";
            }
            {
              colorizeDistroLogo = false;
              colorizeSystemIcon = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = false;
            }
            {
              customFont = "";
              formatHorizontal = "h:mm AP";
              formatVertical = "h:mm AP";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
              usePrimaryColor = true;
            }
          ];
        };
      };
      general = {
        radiusRatio = 0.2;
        enableLockScreenCountdown = true;
        lockScreenCountdownDuration = 10000;
      };
      ui = {
        fontDefault = "Sans Serif";
        fontFixed = "monospace";
      };
      location = {
        name = "Milford, CT";
        useFahrenheit = true;
        use12hourFormat = true;
        showCalendarEvents = false;
      };
      wallpaper = {
        directory = "/home/rick/Pictures/Wallpaper";
      };
      appLauncher = {
        enableClipboardHistory = true;
        terminalCommand = "ghostty -e";
      };
      controlCenter = {
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "WallpaperSelector"; }
            { id = "NoctaliaPerformance"; }
          ];
        };
      };
      systemMonitor = {
        diskPollingInterval = 30000;
      };
    };
  };
}
