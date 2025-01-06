{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    luwpy.enable = lib.mkEnableOption "enables luwpy user";
  };

  config = lib.mkIf config.luwpy.enable {
    users.users.luwpy = {
      isNormalUser = true;
      initialPassword = "1726832";
      extraGroups = ["wheel" "video" "inputs"];
      shell = pkgs.fish;
    };

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "luwpy" = import ../../home/luwpy/home.nix;
      };
    };

    programs.hyprland = lib.mkDefault {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };
  };
}
