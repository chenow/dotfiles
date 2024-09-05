{ pkgs, system, ... }: {
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

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Enables touch ID in ternimal
  security.pam.enableSudoTouchIdAuth = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = system;

  system.defaults.WindowManager.AutoHide = true;
}
