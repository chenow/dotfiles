{...}: let
  setAsGreedyCasks = builtins.map (cask: {
    name = cask;
    greedy = true;
  });
in {
  homebrew = {
    enable = true;
    global.autoUpdate = false;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = setAsGreedyCasks [
      # Development Tools
      "docker"
      "visual-studio-code"
      "wezterm"
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
    caskArgs.no_quarantine = true;
  };
}
