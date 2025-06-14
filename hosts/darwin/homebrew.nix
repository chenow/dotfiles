{
  user,
  inputs,
  ...
}: {
  nix-homebrew = {
    inherit user;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "nikitabobko/tap" = inputs.aerospace-tap;
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
      "aerospace"
      "unetbootin"

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
      "microsoft-auto-update"

      # Browsers
      "arc"

      # Notes
      "obsidian"
    ];
  };
}
