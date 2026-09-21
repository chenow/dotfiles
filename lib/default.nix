{inputs, ...}: {
  caches = import ./caches.nix;
  features = import ./features.nix {inherit (inputs.nixpkgs) lib;};
  eachSystem = inputs.nixpkgs.lib.genAttrs (import inputs.systems);
  makeFormatter = system: treefmtConfig: inputs.treefmt-nix.lib.mkWrapper (inputs.nixpkgs.legacyPackages.${system}) treefmtConfig;

  darwin = {
    # Build a nix-darwin system with Home Manager wired in.
    #
    # Only plumbing (user account, HM integration, flakes) is applied
    # unconditionally. Every feature is opt-in through `my.*` options:
    #   my.macos.*    nix-darwin level (nix daemon, macOS defaults, Homebrew, Hammerspoon)
    #   my.shell.*    zsh, direnv, CLI tools, television, WezTerm
    #   my.dev.*      git, github, ssh, docker, aws, dotfiles
    #   my.editors.*  vscodium, zed, vim
    #   my.ai.*       kiro, agents
    #
    # There are no profiles/bundles: each host file lists every feature it
    # enables. Host and work configuration are passed by the consuming flake.
    #
    # `extraGroups` lists additional `my.<group>` option groups defined by the
    # consumer's Home Manager modules (e.g. ["amazon"]) so they are aliased at
    # the nix-darwin level like the built-in groups.
    mkDarwinSystem = {
      modules,
      system,
      specialArgs ? {},
      extraGroups ? [],
    }:
      inputs.nix-darwin.lib.darwinSystem {
        inherit system specialArgs inputs;
        modules =
          [
            {
              nixpkgs.overlays = [
                inputs.nix-vscode-extensions.overlays.default
                inputs.llm-agents.overlays.shared-nixpkgs
              ];
            }
            {
              home-manager.sharedModules = [
                inputs.agent-skills.homeManagerModules.default
                inputs.nixvim.homeModules.nixvim
              ];
            }
          ]
          ++ [
            inputs.nixvim.nixDarwinModules.nixvim
            inputs.home-manager.darwinModules.home-manager
            inputs.nix-homebrew.darwinModules.nix-homebrew
            ../modules/darwin
            (import ../modules/home.nix extraGroups)
          ]
          ++ modules;
      };
  };

  # Standalone Home Manager configuration (Linux hosts, e.g. cloud desktops).
  # Same `my.shell/dev/editors/ai` options as above; no `my.macos`.
  homeManagerConfiguration = {
    modules,
    pkgs,
    extraSpecialArgs ? {},
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = extraSpecialArgs // {inherit inputs;};
      modules =
        [
          {
            nixpkgs.overlays = [
              inputs.nix-vscode-extensions.overlays.default
              inputs.llm-agents.overlays.shared-nixpkgs
            ];
          }
        ]
        ++ [
          inputs.nixvim.homeModules.nixvim
          inputs.agent-skills.homeManagerModules.default
          ../modules/home-manager
        ]
        ++ modules;
    };
}
