{
  description = "Home Manager configuration of chenow";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, flake-utils
    , pre-commit-env, ... }:
    let
      system = "aarch64-darwin";
      username = "chenow";
      machine = "Chenows-MacbookPro";

      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # Nix darwin configuration
      darwinConfigurations.${machine} = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit system; };
        modules = [ ./system-conf ];
      };
      system.configurationRevision = self.rev or self.dirtyRev or null;
      darwinPackages = self.darwinConfigurations.${machine}.pkgs;

      # Home Manager configuration
      homeConfigurations.${username} =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./user-conf ];
        };
    }

    # Devshells configuration
    // (import ./devshells.nix { inherit nixpkgs flake-utils pre-commit-env; });
}
