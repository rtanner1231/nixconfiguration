{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.settings = {
    daemon = {
      WaylandEnable = false;
    };
  };
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
  services.gvfs.enable = true;
  services.xserver.enable = true;

  services.xserver.videoDrivers = ["nvidia"];

 hardware.nvidia= {
      modesetting.enable=true;
      open=false;
      nvidiaSettings=true;
};

  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-online-accounts.enable = true;

  programs.dconf.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  hardware.bluetooth.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  programs.mango.enable = true;
  programs.mango.addLoginEntry = false;

  # Create a custom wrapper for MangoWM so that it sources the system
  # profile and user profile before starting. This is crucial for GDM
  # and other display managers that might not source `/etc/profile` automatically.
  services.displayManager.sessionPackages = [
    (pkgs.runCommand "mango-wayland-session" {
      passthru.providedSessions = [ "mango" ];
    } ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/mango.desktop <<EOF
      [Desktop Entry]
      Name=Mango
      Comment=Mango Wayland Compositor
      Exec=${pkgs.writeShellScript "mango-wrapper" ''
        if [ -f /etc/profile ]; then
          . /etc/profile
        fi
        if [ -f "\$HOME/.profile" ]; then
          . "\$HOME/.profile"
        fi
        
        # Ensure DBus activation environment is updated
        if command -v dbus-update-activation-environment >/dev/null 2>&1; then
          dbus-update-activation-environment --systemd --all
        fi

        exec ${inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/mango
      ''}
      Type=Application
      EOF
    '')
  ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    upower
    bluez
    python3
    evolution-data-server
    snixembed
    evolution
    gnome-control-center
    inputs.dms.packages.${pkgs.system}.default
  ];

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
    QSG_RENDER_LOOP = "basic";

    # Keep your GI_TYPELIB_PATH exactly as it is [cite: 128]
    GI_TYPELIB_PATH = lib.makeSearchPath "lib/girepository-1.0" (
      with pkgs;
      [
        evolution-data-server
        libical
        glib.out
        libsoup_3
        json-glib
        gobject-introspection
      ]
    );
  };

  # Keep your XDG portals exactly as they are [cite: 134, 135, 139]
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
}
