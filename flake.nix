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
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      flake-utils,
      pre-commit-env,
      nixvim,
      ...
    }:
    let
      system = "aarch64-darwin";
      username = "chenow";
      machine = "MacBook-Pro-de-Antoine";

      pkgs = nixpkgs.legacyPackages.${system};
      pre-commit-lib = pre-commit-env.lib.${system};
    in
    {
      # Nix darwin configuration
      darwinConfigurations.${machine} = nix-darwin.lib.darwinSystem {
        specialArgs = {
          inherit system username;
        };
        modules = [ ./system-conf ];
      };
      system.configurationRevision = self.rev or self.dirtyRev or null;
      darwinPackages = self.darwinConfigurations.${machine}.pkgs;

      # Home Manager configuration
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./user-conf
          nixvim.homeManagerModules.nixvim
        ];
      };

      nixpkgs.config.allowUnfree = true;

      # Formatter configuration
      formatter.${system} = pkgs.nixfmt-rfc-style;

      # Devshells configuration
      devShell.${system} = pre-commit-lib.mkDevShell { };
    };
}
