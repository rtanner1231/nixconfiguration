{ pkgs, profile, ... }:

{

  security.sudo.enable = true;
  # allow nixos rebuilt to be run without password
  security.sudo.extraRules = [
    {
      users = [ profile.user ];
      commands = [
        {
          command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/reboot";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

}
