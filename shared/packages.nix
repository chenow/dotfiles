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

    # Media-related packages
    htop
  ];
}
