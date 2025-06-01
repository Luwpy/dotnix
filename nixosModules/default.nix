{
  pkgs,
  config,
  lib,
  myLib,
  inputs,
  outputs,
  ...
}: let
  cfg = config.myNixOS;

  features = myLib.extendModules (name: {
    extraOptions = {
      myNixOS.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    };
  }) (myLib.filesIn ./features);
in {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ features;

  options.myNixOS = {
    hyprland.enable = lib.mkEnableOption "enable hyprland config";
  };

  config = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}
