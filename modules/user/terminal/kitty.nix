{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.kitty = {
    enable = true;
    package = null;
    font = {
      name = "Victor Mono";
      size = 16;
    };

    settings = {
      background = "#1e1e2e";
      foreground = "#cdd6f4";

      cursor = "#f5e0dc";
      cursor_text_color = "#1e1e2e";

      selection_background = "#f5e0dc";
      selection_foreground = "#1e1e2e";

      window_padding_width = 10;

      cursor_shape = "block";
      cursor_blink_interval = 0.5;

      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 2;

      scrollback_lines = 10000;

      background_opacity = "0.55";

      enable_audio_bell = "no";

      remember_window_size = "no";

      confirm_os_window_close = 0;

      hide_window_decorations = "yes";
    };

    extraConfig = ''
      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b7,U+e700-U+e8ef,U+ed00-U+efc1,U+f000-U+f2ff,U+f000-U+f2e0,U+f300-U+f381,U+f400-U+f533,U+f0001-U+f1af0 MapleMono NF CN

      symbol_map U+4E00-U+9FA5,U+9FA6-U+9FCB LXGW WenKai

      modify_font underline_position 3
      modify_font underline_thickness 50%

      modify_font strikethrough_position 2px

      modify_font cell_width +1px
      modify_font cell_height +3px

      color0 #45475a
      color1 #f38ba8
      color2 #a6e3a1
      color3 #f9e2af
      color4 #89b4fa
      color5 #f5c2e7
      color6 #94e2d5
      color7 #bac2de

      color8 #585b70
      color9 #f38ba8
      color10 #a6e3a1
      color11 #f9e2af
      color12 #89b4fa
      color13 #f5c2e7
      color14 #94e2d5
      color15 #a6adc8
    '';
  };
}
