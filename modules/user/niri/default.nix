{
  config,
  pkgs,
  lib,
  ...
}:

{
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/config/niri/config.kdl";
}
