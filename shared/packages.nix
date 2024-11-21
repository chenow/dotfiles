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

    # Cloud-related tools and SDKs
    docker

    # Media-related packages
    htop
  ];
}
