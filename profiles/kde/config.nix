{ ... }:
{
  services.xserver.enable = true; # optional
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Required to make the SDF cli work
  services.gvfs.enable = true;
}
