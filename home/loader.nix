{ config, pkgs, lib, ... }:

let
  dir = ./modules;
  entries = builtins.readDir dir;
  modules = lib.filterAttrs (name: type:
    type == "regular" && lib.hasSuffix ".nix" name
  ) entries;
in
{
  imports = map (name: dir + "/${name}") (builtins.attrNames modules);
}
