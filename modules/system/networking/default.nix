{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./mihomo.nix
    ./openssh.nix
  ];

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
}
