{ ... }:
{
  homebrew.enable = true;
  homebrew.casks = [
    "arc"
    "microsoft-outlook"
    "microsoft-excel"
    "microsoft-powerpoint"
    "microsoft-teams"
    "microsoft-word"
    "telegram"
    "whatsapp"
    "slack"
    "visual-studio-code"
    "wezterm"
    "obsidian"
    "docker"
    "zoom"
    "eclipse-installer"
  ];
  homebrew.onActivation.cleanup = "zap";
}
