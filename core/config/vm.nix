{ pkgs, ... }:
{
  # Enable dconf (required for virt-manager to save settings)
  programs.dconf.enable = true;

  # Enable libvirtd and virt-manager
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true; # Required for Windows 11 TPM emulation
      # ovmf = {
      #   enable = true;
      #   packages = [ pkgs.OVMFFull.fd ]; # Provides full UEFI and Secure Boot
      # };
    };
  };
  programs.virt-manager.enable = true;

  # Optional but recommended for USB passthrough
  virtualisation.spiceUSBRedirection.enable = true;

  # Replace "yourusername" with your actual user account!
  users.users.rick = {
    extraGroups = [ "libvirtd" ];
  };

  # Install necessary virtualization packages
  environment.systemPackages = with pkgs; [
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
  ];
}
