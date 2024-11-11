{ pkgs }:

with pkgs;
[
  # General packages for development and system management
  # alacritty
  # aspell
  # aspellDicts.en
  # bash-completion
  # bat
  # btop
  # coreutils
  # killall
  neofetch
  direnv
  # openssh
  # sqlite
  # wget
  # zip

  # Encryption and security tools
  # age
  # age-plugin-yubikey
  gnupg
  # libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  # dejavu_fonts
  # ffmpeg
  # fd
  # font-awesome
  # hack-font
  # noto-fonts
  # noto-fonts-emoji
  # meslo-lgs-nf

  # Text and terminal utilities
  htop
  # huVnspell
  # iftop
  # jetbrains-mono
  # jq
  # ripgrep
  # tree
  # tmux
  # unrar
  # unzip
]
