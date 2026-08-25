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
    ./google-chrome.nix
    ./mission-center.nix
  ];

  environment.systemPackages = with pkgs; [
    fastfetch
    pciutils
    tree
  ];
}
