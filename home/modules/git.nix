{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "Annotation1337";
    settings.user.email = "841876168@qq.com";
  };
}
