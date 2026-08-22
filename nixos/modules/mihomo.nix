{ config, pkgs, lib, ... }:

{
  services.mihomo = {
    enable = true;
    configFile = "/home/yjc/nixos-config/config/mihomo/config.yaml";  # 含代理订阅密钥, 勿放 /nix/store
    webui = pkgs.metacubexd;      # 本地面板, 对应 -ext-ui
    tunMode = true;               # 已在 config.yaml 开启 TUN 透明代理
    # extraOpts = "-ext-ctl 127.0.0.1:9090";  # 可选, 额外命令行参数
  };
}
