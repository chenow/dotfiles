{...}: let
  setAsGreedyCasks = builtins.map (cask: {
    name = cask;
    greedy = true;
  });
in {
  homebrew = {
    enable = true;
    global.autoUpdate = false;
    greedyCasks = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = setAsGreedyCasks [
      # Development Tools
      "unetbootin"
      "hammerspoon"
      "figma"
      "telegram-desktop"

      # Messaging
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
      "raycast"
    ];
    caskArgs.no_quarantine = true;
  };
}
