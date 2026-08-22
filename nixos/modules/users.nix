{ config, pkgs, lib, ... }:

{
  users.users."yjc" = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
