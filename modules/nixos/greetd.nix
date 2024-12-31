{ pkgs, lib, config, ... }: {
  options = {
    greeter.greetd = {
      enable = lib.mkEnableOption "greetd";
    };
  };

  config = lib.mkIf config.greeter.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/agreety --cmd Hyprland";
        };
      }
      ;
    };
  };
}
