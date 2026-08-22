{ config, pkgs, lib, ... }:

{
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";  # 禁止 root 直接登录 (普通用户仍可密码登录后 sudo)
  };
}
