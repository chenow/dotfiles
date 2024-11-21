{ pkgs, ... }:
{
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
        # "macos"
        "direnv"
      ];
      theme = "robbyrussell";
    };
    initExtra = ''
      echo "Welcome to Oh My Zsh managed by Home Manager!"
    '';
  };
}
