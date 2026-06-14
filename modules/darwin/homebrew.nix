{...}: let
  setAsGreedyCasks = map (cask: {
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

    taps = [
      "homebrew/bundle"
      "homebrew/cask"
    ];
    casks = setAsGreedyCasks [
      # Development Tools
      "unetbootin"
      "hammerspoon"
      "telegram-desktop"

      # Messaging
      "whatsapp"

      # Browsers
      "raycast"
    ];
    caskArgs.no_quarantine = true;
  };
}
