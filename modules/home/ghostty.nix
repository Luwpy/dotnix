{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.terminals.ghostty;
in {
  options.terminals.ghostty.enable = lib.mkEnableOption "Enable ghostty terminal";

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.ghostty.packages.${pkgs.system}.default
    ];
  };
}
