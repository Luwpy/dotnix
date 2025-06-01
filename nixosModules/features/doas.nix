{
  config,
  lib,
  ...
}: {
  security = {
    doas = {
      extraRules = [
        {
          groups = ["doas"];
          noPass = false;
          keepEnv = true;
          persist = true;
        }
      ];
    };
    sudo.enable = lib.mkForce false;
  };
}
