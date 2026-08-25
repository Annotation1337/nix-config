{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    brightnessctl
    playerctl
  ];
  nixpkgs.overlays = [
    (final: prev: {
      niri = prev.niri.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
          substituteInPlace $out/bin/niri-session \
            --replace "systemctl --user import-environment" \
                      "systemctl --user import-environment >/dev/null 2>&1" \
            --replace "dbus-update-activation-environment --all" \
                      "dbus-update-activation-environment --all >/dev/null 2>&1"
        '';
      });
    })
  ];
}
