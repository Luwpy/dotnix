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

    # hardware.graphics.driSupport32Bit = true;
    hardware.graphics.enable = true;

    environment.systemPackages = with pkgs; [
      mesa
      vulkan-tools
      lutris
    ];
  };
}
