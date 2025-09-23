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
  services.gvfs.enable = true;
  services.xserver.enable = false;

  services.displayManager.sessionPackages = [ pkgs.niri ];
  security.pam.services.gdm.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  environment.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
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
