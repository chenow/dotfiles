{
  description = "Starter Configuration for MacOS and NixOS";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    aerospace-tap = {
      url = "github:nikitabobko/homebrew-AeroSpace";
      flake = false;
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-env = {
      url = "github:chenow/nix-pre-commit";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };
  outputs = {
    self,
    darwin,
    home-manager,
    nixpkgs,
    nixpkgs-darwin,
    nixpkgs-nixos,
    systems,
    ...
  } @ inputs: let
    user = "chenow";
    linuxSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    darwinSystems = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    treefmtConfig = import ./treefmt.nix;
  in
    {
      darwinConfigurations."MacBook-Pro-de-Antoine" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit self inputs user;
        };
        modules = [
          ./hosts/darwin
          home-manager.darwinModules.home-manager
          inputs.nixvim.nixDarwinModules.nixvim
          inputs.nix-homebrew.darwinModules.nix-homebrew
        ];
      };

      nixosConfigurations = {
        nixos = nixpkgs-nixos.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs user;
          };
          modules = [
            home-manager.nixosModules.home-manager
            inputs.nixvim.nixosModules.nixvim
            ./hosts/nixos
          ];
        };
      };
      formatter = eachSystem (pkgs: inputs.treefmt-nix.lib.mkWrapper pkgs treefmtConfig);
    }
    // inputs.flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = inputs.pre-commit-env.lib.${system}.mkDevShell {};
    });
}
