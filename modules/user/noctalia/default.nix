{
  config,
  pkgs,
  lib,
  ...
}:

{
  xdg.configFile."noctalia/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/config/noctalia/config.toml";
}
