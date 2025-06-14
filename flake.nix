{
  description = "My MacOS configuration using Nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nix-darwin,
    nixpkgs,
    ...
  } @ inputs: let
    user = "chenow";
    treefmtConfig = import ./treefmt.nix;
  in {
    # MacOS configuration
    darwinConfigurations."MacBook-Pro-de-Antoine" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit self inputs user;
      };
      modules = [
        ./hosts/darwin
        inputs.home-manager.darwinModules.home-manager
        inputs.nixvim.nixDarwinModules.nixvim
      ];
    };

    # Formatters configuration
    formatter = {
      aarch64-darwin.default = inputs.treefmt-nix.lib.mkWrapper (nixpkgs.legacyPackages.aarch64-darwin) treefmtConfig;
      x86_64-linux.default = inputs.treefmt-nix.lib.mkWrapper (nixpkgs.legacyPackages.x86_64-linux) treefmtConfig;
    };
  };
}
