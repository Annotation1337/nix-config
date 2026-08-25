{
  config,
  pkgs,
  lib,
  ...
}:

{
  xdg.configFile."kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/config/kitty/kitty.conf";
}
