{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    # inputs.stylix.nixosModules.stylix
    ./../../modules/home
  ];

  home.stateVersion = "24.05";

  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "VMs"
      "Projects"
      ".gnupg"
      ".ssh"
      ".config"
      "dotnix"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".screenrc"
    ];

    allowOther = true;
  };

  wms.hypr.enable = true;
  terminals.ghostty.enable = true;
}
