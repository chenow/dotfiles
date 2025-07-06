{
  description = "My MacOS configuration using Nix";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems = {
      url = "github:nix-systems/default";
    };
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
  outputs = {self, ...} @ inputs: let
    user = "chenow";
    treefmtConfig = import ./treefmt.nix;
  in {
    # MacOS configuration
    darwinConfigurations."MacBook-Pro-de-Antoine" = self.lib.darwin.mkDarwinSystem {
      system = "aarch64-darwin";
      modules = [./hosts/MacBook-Pro-de-Antoine];
      specialArgs = {
        inherit self inputs user;
      };
    };

    # Exposes lib to external flakes
    lib = import ./lib {
      inherit inputs;
    };

    # Formatters configuration
    formatter = self.lib.eachSystem (system: self.lib.makeFormatter system treefmtConfig);
  };
}
