{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # General packages for development and system management
    fastfetch
    git
    fzf
    firebase-tools
    ngrok

    # Nix-related packages
    cachix

    # Media-related packages
    htop
  ];
}
