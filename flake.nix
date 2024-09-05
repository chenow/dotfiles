{
  description = "Home Manager configuration of chenow";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-env = {
      url = "github:chenow/nix-pre-commit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, pre-commit-env }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."chenow" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./modules/home.nix ];
      };
    }

    # Devshells configuration
    // (import ./devshells.nix { inherit nixpkgs flake-utils pre-commit-env; });
}
