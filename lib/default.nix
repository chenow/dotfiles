{inputs, ...}: {
  eachSystem = inputs.nixpkgs.lib.genAttrs (import inputs.systems);
  makeFormatter = system: treefmtConfig: inputs.treefmt-nix.lib.mkWrapper (inputs.nixpkgs.legacyPackages.${system}) treefmtConfig;

  darwin = {
    # Function to create a darwin system configuration
    mkDarwinSystem = {
      modules,
      system,
      specialArgs ? {},
    }:
      inputs.nix-darwin.lib.darwinSystem {
        inherit system specialArgs inputs;
        modules =
          [
            inputs.nixvim.nixDarwinModules.nixvim
            inputs.home-manager.darwinModules.home-manager
            ../modules/darwin
            ../modules/home.nix
            ../profiles
          ]
          ++ modules;
      };
  };
  homeManagerConfiguration = {
    modules,
    pkgs,
    extraSpecialArgs ? {},
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit extraSpecialArgs pkgs;
      modules =
        [
          inputs.nixvim.homeModules.nixvim
          ../modules/home-manager
          ../profiles
        ]
        ++ modules;
    };
}
