{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.bash.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config/.#nixos";
    ff = "fastfetch";

  };
}
