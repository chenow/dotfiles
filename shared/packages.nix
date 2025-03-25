{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # General packages for development and system management
    fastfetch
    git
    fzf
    firebase-tools
    ngrok
    awscli
    terraform
    google-cloud-sdk
    google-cloud-sql-proxy

    # Programming languages related packages
    python313Full
    maven
    bun
    nodejs
    spark

    # Nix-related packages
    cachix

    # Media-related packages
    htop
  ];
}
