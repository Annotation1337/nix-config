{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{

  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.noctalia-greeter = {
    enable = true;

    greeter-args = "";
    settings = {
      output = {
        scale = 1.2;
      };
      appearance = {
        hide_logo = true;
      };
#       cursor = {
   #     theme = "Bibata-Modern-Ice";
   #     size = 24;
   #     path = "${pkgs.bibata-cursors}/share/icons";
   #   };
      keyboard = {
        layout = "us";
      };
    };
  };
}
