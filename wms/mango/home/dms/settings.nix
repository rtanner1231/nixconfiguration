{ config, pkgs, ... }:

{
  programs.dank-material-shell = {

    settings = {
      # --- Theming & Styling ---
      currentThemeName = "purple";
      currentThemeCategory = "generic";
      matugenScheme = "scheme-tonal-spot";
      runUserMatugenTemplates = true;
      popupTransparency = 1;
      dockTransparency = 1;
      widgetBackgroundColor = "sch";
      widgetColorMode = "default";
      controlCenterTileColorMode = "primary";
      buttonColorMode = "primary";
      cornerRadius = 12;

      # --- Localization & Preferences ---
      use24HourClock = false;
      useFahrenheit = true;
      windSpeedUnit = "kmh";
      clockDateFormat = "M/d";

      # --- Fonts ---
      fontFamily = "Inter Variable";
      monoFontFamily = "Fira Code";
      fontWeight = 400;
      fontScale = 1;

      # --- Animations & Blur ---
      animationSpeed = 1;
      customAnimationDuration = 500;
      syncComponentAnimationSpeeds = true;
      popoutAnimationSpeed = 1;
      popoutCustomAnimationDuration = 150;
      modalAnimationSpeed = 1;
      modalCustomAnimationDuration = 150;
      enableRippleEffects = true;
      blurLayerOutlineOpacity = 0.12;
      blurBorderColor = "outline";
      blurBorderCustomColor = "#ffffff";
      blurBorderOpacity = 0.35;
      wallpaperFillMode = "Fill";

      # --- Widgets & Indicators ---
      showLauncherButton = true;
      showWorkspaceSwitcher = true;
      showFocusedWindow = true;
      showWeather = true;
      showMusic = true;
      showClipboard = true;
      showCpuUsage = true;
      showMemUsage = true;
      showCpuTemp = true;
      showSystemTray = true;
      systemTrayIconTintSaturation = 50;
      systemTrayIconTintStrength = 135;
      showClock = true;
      showNotificationButton = true;
      showBattery = true;
      showControlCenterButton = true;
      showCapsLockIndicator = true;
      showPrivacyButton = true;

      # --- Control Center ---
      controlCenterShowNetworkIcon = true;
      controlCenterShowBluetoothIcon = true;
      controlCenterShowAudioIcon = true;
      controlCenterShowVpnIcon = true;
      controlCenterShowMicPercent = true;
      controlCenterShowScreenSharingIcon = true;
      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "brightnessSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "wifi";
          enabled = true;
          width = 50;
        }
        {
          id = "bluetooth";
          enabled = true;
          width = 50;
        }
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "nightMode";
          enabled = true;
          width = 50;
        }
        {
          id = "darkMode";
          enabled = true;
          width = 50;
        }
      ];

      # --- Workspace Settings ---
      showWorkspaceIndex = true;
      workspaceDragReorder = true;
      maxWorkspaceIcons = 3;
      groupWorkspaceApps = true;
      workspaceFollowFocus = true;
      workspaceColorMode = "default";
      workspaceOccupiedColorMode = "none";
      workspaceUnfocusedColorMode = "default";
      workspaceUrgentColorMode = "default";
      workspaceFocusedBorderColor = "primary";
      workspaceFocusedBorderThickness = 2;

      # --- Behavior & Visuals ---
      waveProgressEnabled = true;
      scrollTitleEnabled = true;
      audioVisualizerEnabled = true;
      audioScrollMode = "volume";
      audioWheelScrollAmount = 5;
      runningAppsCompactMode = true;
      barShowOverflowBadge = true;
      appsDockColorizeActive = true;
      appsDockActiveColorMode = "primary";
      appsDockEnlargePercentage = 125;
      appsDockIconSizePercentage = 100;
      runningAppsCurrentWorkspace = true;
      centeringMode = "index";

      # --- Media & Launchers ---
      mediaSize = 1;
      appLauncherViewMode = "list";
      spotlightModalViewMode = "list";
      browserPickerViewMode = "grid";
      appPickerViewMode = "grid";
      appLauncherGridColumns = 4;
      spotlightCloseNiriOverview = true;
      spotlightSectionViewModes = {
        apps = "list";
      };
      niriOverviewOverlayEnabled = true;
      dankLauncherV2Size = "compact";
      dankLauncherV2BorderThickness = 2;
      dankLauncherV2BorderColor = "primary";
      dankLauncherV2ShowFooter = true;
      weatherEnabled = true;
      networkPreference = "auto";
      iconTheme = "System Default";

      # --- Cursors ---
      cursorSettings = {
        theme = "System Default";
        size = 24;
        niri = {
          hideWhenTyping = false;
          hideAfterInactiveMs = 0;
        };
        hyprland = {
          hideOnKeyPress = false;
          hideOnTouch = false;
          inactiveTimeout = 0;
        };
        dwl = {
          cursorHideTimeout = 0;
        };
      };

      launcherLogoMode = "apps";
      launcherLogoBrightness = 0.5;
      launcherLogoContrast = 1;

      # --- Applications (Notepad, Terminal, etc.) ---
      notepadUseMonospace = true;
      notepadFontSize = 14;
      notepadLastCustomTransparency = 0.7;
      soundsEnabled = true;
      soundNewNotification = true;
      soundVolumeChanged = true;
      soundPluggedIn = true;

      batteryChargeLimit = 100;
      loginctlLockIntegration = true;
      fadeToLockEnabled = true;
      fadeToLockGracePeriod = 5;
      fadeToDpmsEnabled = true;
      fadeToDpmsGracePeriod = 5;

      syncModeWithPortal = true;
      muxType = "tmux";
      runDmsMatugenTemplates = true;

      # --- Matugen Templates ---
      matugenTemplateGtk = true;
      matugenTemplateNiri = true;
      matugenTemplateHyprland = true;
      matugenTemplateMangowc = true;
      matugenTemplateQt5ct = true;
      matugenTemplateQt6ct = true;
      matugenTemplateFirefox = true;
      matugenTemplatePywalfox = true;
      matugenTemplateZenBrowser = true;
      matugenTemplateVesktop = true;
      matugenTemplateEquibop = true;
      matugenTemplateGhostty = true;
      matugenTemplateKitty = true;
      matugenTemplateFoot = true;
      matugenTemplateAlacritty = true;
      matugenTemplateNeovim = false;
      matugenTemplateWezterm = true;
      matugenTemplateDgop = true;
      matugenTemplateKcolorscheme = true;
      matugenTemplateVscode = true;
      matugenTemplateEmacs = true;
      matugenTemplateZed = true;

      # --- Dock Settings ---
      dockAutoHide = true;
      dockPosition = 1;
      dockSpacing = 4;
      dockIconSize = 40;
      dockIndicatorStyle = "circle";
      dockBorderColor = "surfaceText";
      dockBorderOpacity = 1;
      dockBorderThickness = 1;
      dockLauncherLogoMode = "apps";
      dockLauncherLogoBrightness = 0.5;
      dockLauncherLogoContrast = 1;
      dockShowOverflowBadge = true;

      # --- Lock Screen & Notifications ---
      notificationPopupShadowEnabled = true;
      modalDarkenBackground = true;
      lockScreenShowPowerActions = true;
      lockScreenShowSystemIcons = true;
      lockScreenShowTime = true;
      lockScreenShowDate = true;
      lockScreenShowProfileImage = true;
      lockScreenShowPasswordField = true;
      lockScreenShowMediaPlayer = true;
      maxFprintTries = 15;
      u2fMode = "or";
      lockScreenActiveMonitor = "all";
      lockScreenInactiveColor = "#000000";

      notificationTimeoutLow = 5000;
      notificationTimeoutNormal = 5000;
      notificationAnimationSpeed = 1;
      notificationCustomAnimationDuration = 400;
      notificationHistoryEnabled = true;
      notificationHistoryMaxCount = 50;
      notificationHistoryMaxAgeDays = 7;
      notificationHistorySaveLow = true;
      notificationHistorySaveNormal = true;
      notificationHistorySaveCritical = true;

      # --- OSD & Power ---
      osdPosition = 5;
      osdVolumeEnabled = true;
      osdBrightnessEnabled = true;
      osdIdleInhibitorEnabled = true;
      osdMicMuteEnabled = true;
      osdCapsLockEnabled = true;
      osdPowerProfileEnabled = true;
      osdAudioOutputEnabled = true;
      powerActionConfirm = true;
      powerActionHoldDuration = 0.5;
      powerMenuActions = [
        "reboot"
        "logout"
        "poweroff"
        "lock"
        "suspend"
        "restart"
      ];
      powerMenuDefaultAction = "logout";

      displayNameMode = "system";
      displaySnapToEdge = true;

      # --- Main Bar Configuration ---
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;

          leftWidgets = [
            {
              id = "launcherButton";
              enabled = true;
            }
            {
              id = "workspaceSwitcher";
              enabled = true;
            }
            {
              id = "layout";
              enabled = true;
            }
            {
              id = "appsDock";
              enabled = true;
              barShowOverflowBadge = true;
            }
          ];
          centerWidgets = [
            "music"
            {
              id = "clock";
              enabled = true;
              clockCompactMode = false;
            }
            "weather"
          ];
          rightWidgets = [
            {
              id = "systemTray";
              enabled = true;
            }
            {
              id = "privacyIndicator";
              enabled = true;
            }
            {
              id = "cpuUsage";
              enabled = true;
            }
            {
              id = "memUsage";
              enabled = true;
            }
            {
              id = "notificationButton";
              enabled = true;
            }
            {
              id = "idleInhibitor";
              enabled = true;
            }
            {
              id = "battery";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
            }
          ];

          spacing = 4;
          innerPadding = 4;
          widgetTransparency = 1;
          widgetPadding = 8;
          gothCornerRadiusValue = 12;
          transparency = 0;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;
          fontScale = 1;
          iconScale = 1;
          autoHideDelay = 250;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          maximizeDetection = true;
          scrollEnabled = true;
          scrollXBehavior = "column";
          scrollYBehavior = "workspace";
          shadowOpacity = 60;
          shadowColorMode = "text";
          shadowCustomColor = "#000000";
        }
      ];

      # --- System Monitor & Plugins ---
      desktopClockStyle = "analog";
      desktopClockTransparency = 0.8;
      desktopClockColorMode = "primary";
      desktopClockShowDate = true;
      desktopClockShowAnalogSeconds = true;
      desktopClockWidth = 280;
      desktopClockHeight = 180;
      desktopClockDisplayPreferences = [ "all" ];

      systemMonitorShowHeader = true;
      systemMonitorTransparency = 0.8;
      systemMonitorColorMode = "primary";
      systemMonitorShowCpu = true;
      systemMonitorShowCpuGraph = true;
      systemMonitorShowCpuTemp = true;
      systemMonitorShowMemory = true;
      systemMonitorShowMemoryGraph = true;
      systemMonitorShowNetwork = true;
      systemMonitorShowNetworkGraph = true;
      systemMonitorShowDisk = true;
      systemMonitorTopProcessCount = 3;
      systemMonitorTopProcessSortBy = "cpu";
      systemMonitorGraphInterval = 60;
      systemMonitorLayoutMode = "auto";
      systemMonitorWidth = 320;
      systemMonitorHeight = 480;
      systemMonitorDisplayPreferences = [ "all" ];

      builtInPluginSettings = {
        dms_settings_search = {
          trigger = "?";
        };
      };

      configVersion = 5;
    };
  };
}
