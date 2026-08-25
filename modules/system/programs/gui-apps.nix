{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    nautilus
    loupe
    papers
    gnome-text-editor
  ];
}
