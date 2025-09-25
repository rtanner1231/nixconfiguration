{ ... }:
{

  services.xserver.enable = true;

  services.xserver.desktopManager.cinnamon.enable = true;

  services.xserver.displayManager.lightdm.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;

  services.gvfs.enable = true;
}
