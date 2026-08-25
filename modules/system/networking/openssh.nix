{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
  };
}
