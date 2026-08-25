{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./printing.nix
    ./fwupd.nix
  ];
}
