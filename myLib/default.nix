inputs: let
  myLib = (import ./default.nix) {inherit inputs;};
  outputs = inputs.self.outputs;
  nixpkgs = inputs.nixpkgs;
in rec {
  # ================================================================ #
  # =                            My Lib                            = #
  # ================================================================ #

  # =========================== Helpers ============================ #

  # Import overlays
  myOverlays = import ./../overlays {inherit inputs outputs;};

  # Get packages for a specific system
  pkgsFor = system:
    import nixpkgs {
      inherit system;
      overlays = myOverlays;
    };

  # Overlay module definition
  overlayModule = {
    nixpkgs.overlays = myOverlays;
  };

  # List all files in a directory
  filesIn = dir:
    map (fname: "${dir}/${fname}")
    (builtins.attrNames (builtins.readDir dir));

  # List all directories in a directory
  dirsIn = dir:
    nixpkgs.lib.filterAttrs (name: value: value == "directory")
    (builtins.readDir dir);

  # Get the base name of a file without its extension
  fileNameOf = path: builtins.head (builtins.split "\\." (baseNameOf path));

  # ========================== Buildables ========================== #

  # Function to create a NixOS system configuration
  mkSystem = config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          myLib
          ;
      };
      modules = [
        config
        outputs.nixosModules.default
        overlayModule
      ];
    };

  # Function to create a Home Manager configuration
  mkHome = sys: config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor sys;
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          myLib
          ;
      };
      modules = [
        config
        outputs.homeManagerModules.default
      ];
    };

  # ========================== Extenders =========================== #

  # Extend a single module with additional options or configuration
  extendModule = {path, ...} @ args: {pkgs, ...} @ margs: let
    eval =
      if (builtins.isString path) || (builtins.isPath path)
      then import path margs
      else path margs;
    evalNoImports = builtins.removeAttrs eval ["imports" "options"];

    extra =
      if (builtins.hasAttr "extraOptions" args) || (builtins.hasAttr "extraConfig" args)
      then [
        ({...}: {
          options = args.extraOptions or {};
          config = args.extraConfig or {};
        })
      ]
      else [];
  in {
    imports = (eval.imports or []) ++ extra;

    options =
      if builtins.hasAttr "optionsExtension" args
      then args.optionsExtension (eval.options or {})
      else (eval.options or {});

    config =
      if builtins.hasAttr "configExtension" args
      then args.configExtension (eval.config or evalNoImports)
      else (eval.config or evalNoImports);
  };

  # Extend multiple modules with a common extension
  extendModules = extension: modules:
    map
    (f: let
      name = fileNameOf f;
    in
      extendModule ((extension name) // {path = f;}))
    modules;
}
