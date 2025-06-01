{
  config,
  pkgs,
  ...
}: {
  home.username = "luwpy";
  home.homeDirectory = "/home/luwpy";

  programs.zsh.enable = true;
  programs.git.enable = true;

  home.packages = with pkgs; [
    # Add your desired packages here
    vim
    htop
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Add more configurations as needed
}
