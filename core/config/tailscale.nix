{ ... }:
{
  services.tailscale.enable = true;

  # Allow all incoming connections across your Tailscale mesh network
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # (Optional) Prevent your machine from suspending while away from your desk
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
}
