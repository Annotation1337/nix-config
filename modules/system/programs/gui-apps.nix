{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    nautilus
    pcmanfm
    loupe
    papers
    gnome-text-editor
  ];
}
