{
  config,
  pkgs,
  lib,
  ...
}:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    victor-mono
    lxgw-wenkai
    maple-mono.NF-CN-unhinted
    inter
  ];
}
