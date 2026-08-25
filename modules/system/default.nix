{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./audio
    ./boot
    ./environment
    #./gnome
    ./i18n
    ./networking
    ./niri
    ./noctalia
    ./noctalia-greeter
    ./nix
    ./programs
    ./security
    ./services
    ./users
    ./virtualization
  ];
}
