{ config, pkgs, ... }:

{
  home.username = "chenow";
  home.homeDirectory = "/Users/chenow";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    fzf
    vim
    direnv
    zsh
  ];

  home.file = {
    ".config/direnv/direnv.toml".source = ./confs/direnv.toml;
  };

  home.sessionVariables = {
    EDITOR = "code";
    DOTFILES = "/Users/chenow/Documents/git/dotfiles";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "macos"
        "direnv"
      ];
      theme = "robbyrussell";

    };
    initExtra = ''
      echo "Welcome to Oh My Zsh managed by Home Manager!"
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.shellAliases = {
    shell = "docker compose run --rm shell";
    ga = "git add .";
    gck = "git checkout";
    grc = "git rebase --continue";
    gski = "git stash --keep-index";
    user-up = "home-manager switch --flake $DOTFILES";
    system-up = "darwin-rebuild switch --flake $DOTFILES";
  };
}
