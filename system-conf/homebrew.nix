{ ... }:
{
  homebrew.enable = true;
  homebrew.casks = [
    "arc"
    "notion"
    "notion-calendar"
    "microsoft-outlook"
    "microsoft-excel"
    "microsoft-powerpoint"
    "microsoft-teams"
    "microsoft-word"
    "telegram"
    "whatsapp"
    "slack"
    "visual-studio-code"
  ];
  homebrew.onActivation.cleanup = "zap";
}
