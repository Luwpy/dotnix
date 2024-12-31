{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming modules";
  };

  config = lib.mkIf config.gaming.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
