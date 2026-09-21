{
  lib,
  config,
  user,
  pkgs,
  ...
}: let
  cfg = config.my.macos.homebrew;
in {
  options.my.macos.homebrew = {
    enable = lib.mkEnableOption "Homebrew: installation pinned by nix-homebrew, casks/formulae managed by nix-darwin with an opinionated policy (greedy casks, zap cleanup)";

    casks = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = ["raycast" "hammerspoon"];
      description = "Cask names to install. Each cask is installed greedy so it is upgraded on activation.";
    };

    brews = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Formula names to install.";
    };

    rosetta = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Also install an Intel (x86_64) Homebrew prefix under /usr/local for Rosetta 2 (Apple Silicon only).";
    };
  };

  config = lib.mkIf cfg.enable {
    # Homebrew itself (the `brew` program and its version) comes from the
    # nix-homebrew flake input; formulae and casks stay imperative-ish and are
    # upgraded on activation (see homebrew.onActivation below).
    # https://github.com/zhaofengli/nix-homebrew
    nix-homebrew = {
      enable = true;
      inherit user;
      # Take over an installation made with the official script: the Homebrew
      # git repository is deleted, installed formulae/casks are kept.
      autoMigrate = true;
      enableRosetta = cfg.rosetta && pkgs.stdenv.hostPlatform.isAarch64;
      # Taps are not pinned on purpose: pinning homebrew-core/cask would also
      # pin cask versions, which defeats greedy upgrades.
      mutableTaps = true;
    };

    homebrew = {
      enable = true;
      global.autoUpdate = false;
      greedyCasks = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        upgrade = true;
      };

      casks = map (name: {
        inherit name;
        greedy = true;
      }) (lib.unique cfg.casks);
      brews = lib.unique cfg.brews;
    };
  };
}
