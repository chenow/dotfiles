{ user, ... }:

{
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "24.05"; # Check Home Manager release notes before updating

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Checks version mismatches between Nixpkgs and Home Manager.
  home.enableNixpkgsReleaseCheck = true;
}
