{
  pkgs,
  config,
  inputs,
  ...
}: {
  # imports = [
  #   inputs.sops-nix.nixosModules.sops
  # ];
  #
  # sops = {
  #   defaultSopsFile = ./../../hosts/secrets.yaml;
  #   defaultSopsFormat = "yaml";
  #   # age.generateKeys = true;
  #   secrets.example-key = {
  #     owner = config.users.users.luwpy.name;
  #   };
  #   secrets."myservice/my_subdir/my_secret" = {
  #     owner = "sometestservice";
  #   };
  # };
  #
  # systemd.services."sometestservice" = {
  #   script = ''
  #     echo "
  #       Hey bro! I'm a service, and imma send this secure password:
  #       $(cat ${config.sops.secrets."myservice/my_subdir/my_secret".path})
  #       located in:
  #       ${config.sops.secrets."myservice/my_subdir/my_secret".path}
  #       to database and hack the mainframe 😎👍
  #       " > /var/lib/sometestservice/testfile
  #   '';
  #   serviceConfig = {
  #     User = "sometestservice";
  #     workingDirectory = "/var/lib/sometestservice";
  #   };
  # };
  #
  # users.users.sometestservice = {
  #   home = "/var/lib/sometestservice";
  #   createHome = true;
  #   isSystemUser = true;
  #   group = "sometestservice";
  # };
  # users.groups.sometestservice = {};
}
