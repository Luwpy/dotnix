{pkgs, lib, config, ... }:

with lib;

let
  cfg = config.terminals.wezterm;
in {

  options = {
    terminals.wezterm =
    {
      enable = mkEnableOption "wezterm";
      package = mkOption {
        type = types.package;
        default = pkgs.wezterm;
        description = "Wezterm package";
      };
      settings = mkOption {

      };
    };

  };
}
