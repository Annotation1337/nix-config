{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./gdm.nix
    ./fonts.nix
    ./gui-apps.nix
    ./kitty.nix
    ./git.nix

    ./mission-center.nix
    ./brave-origin.nix
  ];

  environment.systemPackages = with pkgs; [
    fastfetch
    pciutils
    tree
  ];
}
