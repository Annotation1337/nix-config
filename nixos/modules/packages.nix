{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    fastfetch
    pciutils
    tree
  ];
}
