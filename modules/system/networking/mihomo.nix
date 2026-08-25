{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.mihomo = {
    enable = true;
    configFile = "/home/yjc/nixos-config/config/mihomo/config.yaml";
    webui = pkgs.metacubexd;
    tunMode = true;
  };
}
