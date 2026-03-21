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
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agent-skills = {
      url = "github:Kyure-A/agent-skills-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    anthropic-skills = {
      url = "github:anthropics/skills";
      flake = false;
    };
  };
  nixConfig.extra-substituters = [
    "https://nix-community.cachix.org/"
    "https://cache.numtide.com"
    "https://nixpkgs-unfree.cachix.org"
  ];
  nixConfig.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
  ];

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
        host = "MacBook-Pro-de-Antoine";
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
