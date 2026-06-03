{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  services.displayManager.gdm.enable = true;
  services.gvfs.enable = true;
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.wayland=false;

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

  # Add MangoWM to your display manager's session packages
  # so GDM knows it exists and gives you a login option.
  services.displayManager.sessionPackages = [
    inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.default
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
