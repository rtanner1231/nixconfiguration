{ pkgs, inputs, ... }:
{
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.niri}/bin/niri-session";
  #     };
  #   };
  # };
  services.displayManager.gdm.enable = true;
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;
  services.gvfs.enable = true;
  services.xserver.enable = false;

  #services.gnome.evolution-data-server.enable = true;

  services.displayManager.sessionPackages = [ pkgs.niri ];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # 2. Enable Bluetooth (Fixes bluetoothctl error)
  hardware.bluetooth.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    upower
    bluez
    python3
    evolution-data-server
    snixembed
    #evolution
  ];

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      # xdg-desktop-portal-gnome
    ];
    config.common.default = "gtk";
    # config = {
    #   niri = {
    #     default = [ "gtk" ];
    #   };
    #   # Fallback for other desktops or if niri isn't detected correctly
    #   common = {
    #     default = [ "gtk" ];
    #   };
    # };
    # config = {
    #   common = {
    #     default = [
    #       "gnome"
    #       "gtk"
    #     ];
    #     "org.freedesktop.impl.portal.Access" = [ "gtk" ];
    #     "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
    #     "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    #     "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    #   };
    # };
  };
}
