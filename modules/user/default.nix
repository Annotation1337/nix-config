{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./home
    ./terminal
    ./git
    ./niri
    ./noctalia
  ];
}
