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
    direnv
    git
    fzf

    # Media-related packages
    htop
  ];
}
