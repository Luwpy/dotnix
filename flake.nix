{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/ed91a20c84a80a525780dcb5ea3387dddf6cd2de";

    ags.url = "github:Aylur/ags/";
    sops-nix.url = "github:Mic92/sops-nix";

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    with (import ./myLib inputs); {
      nixosConfigurations = {
        athena = mkSystem ./hosts/athena/configuration.nix;
      };

      homeManagerConfigurations = {
        "luwpy@athena" = mkHome "x86_64-linux" ./hosts/athena/home.nix;
      };

      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
}
