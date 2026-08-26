{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./fonts.nix
    ./gui-apps.nix
    ./kitty.nix
    ./git.nix
    ./mission-center.nix
    ./brave-origin.nix
    ./opencode.nix
  ];

  environment.systemPackages = with pkgs; [
    fastfetch
    pciutils
    tree
  ];
}
