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
      init.defaultBranch = "main";
      user = {
        email = "jpcastro.sp@gmail.com";
        name = "Luwpy";
      };
    };
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent = {
    enable = lib.modules.mkIf pkgs.stdenv.isLinux true;
  };
}
