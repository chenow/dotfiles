{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # General packages for development and system management
    fastfetch
    git
    fzf
    firebase-tools
    ngrok
    google-cloud-sdk
    google-cloud-sql-proxy

    # Programming languages related packages
    terraform
    python313Full
    bun
    nodejs
    uv

    # Media-related packages
    htop
    rectangle
  ];
}
