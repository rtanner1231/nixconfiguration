{
  config,
  pkgs,
  inputs,
  ...
}:
{

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.adwaita-icon-theme
  ];

  # Required to make the SDF cli work
  services.gvfs.enable = true;
  # Hyprland is a wayland compositor, so we don't need X11
  services.xserver.enable = false;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
        user = "greeter";
      };
    };
  };
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Enable Hyprland
  programs.hyprland.enable = true;

  # For screen sharing
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

}
