{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  enableGreetd = mkEnableOption "greetd display manager with tuigreet and Hyprland session";
in {
  options.greeter.greetd.enable = enableGreetd;

  config = mkIf config.greeter.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "luwpy";
        };
      };
    };
  };
}
