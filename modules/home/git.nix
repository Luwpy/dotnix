{
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "helix";
      credential.helper = "store";
      github.user = "Luwpy";
      push.autoSetupRemote = true;
    };
    userEmail = "jpcastro.sp@gmail.com";
    userName = "Luwpy";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent = {
    enable = lib.modules.mkIf pkgs.stdenv.isLinux true;
  };
}
