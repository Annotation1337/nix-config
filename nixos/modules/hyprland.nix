{ config, pkgs, lib, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;        # 推荐, 与 systemd 集成更好 (NixOS 24.11+)
    xwayland.enable = true; # Xwayland 兼容层
  };

  # Hyprland 默认配置依赖 kitty 终端
  environment.systemPackages = with pkgs; [
    kitty
  ];

  # 提示 Electron 应用使用 Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
