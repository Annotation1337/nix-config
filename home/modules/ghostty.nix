{ config, pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      theme = "Catppuccin Mocha";

      # 字体
      font-family = "JetBrainsMono Nerd Font";
      font-size = 13;
      adjust-cell-height = "5%";    # 行高微调, 视觉更舒展

      # 半透明
      background-opacity = 0.88;    # 0.0 全透 ~ 1.0 不透

      # 窗口内边距
      window-padding-x = 12;
      window-padding-y = 12;

      # 光标
      cursor-style = "block";
      cursor-style-blink = true;
      cursor-invert-fg-bg = true;

      # 杂项
      mouse-hide-while-typing = true;
      copy-on-select = "clipboard";
      confirm-close-surface = false;
      scrollback-limit = 100000;
    };
  };
}
