{ config, pkgs, lib, ... }:

{
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };
}
