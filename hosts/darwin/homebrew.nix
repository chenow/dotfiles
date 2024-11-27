{
  pkgs,
  lib,
  config,
  user,
  inputs,
  ...
}:

{

  nix-homebrew = {
    inherit user;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    mutableTaps = false;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation.cleanup = "zap";
    casks = [
      # Development Tools
      "docker"
      "visual-studio-code"
      "wezterm"

      # Communication Tools
      "slack"
      "telegram"
      "zoom"
      "whatsapp"

      # Microsoft suite
      "microsoft-outlook"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-teams"
      "microsoft-word"

      # Browsers
      "arc"

      # Notes
      "obsidian"
    ];
  };
}
