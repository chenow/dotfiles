{...}: let
  setAsGreedyCasks = builtins.map (cask: {
    name = cask;
    greedy = true;
  });
in {
  homebrew = {
    enable = true;
    global.autoUpdate = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = setAsGreedyCasks [
      # Development Tools
      "docker"
      "unetbootin"

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
    ];
    caskArgs.no_quarantine = true;
  };
}
