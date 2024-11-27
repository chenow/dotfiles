{
  pkgs,
  config,
  lib,
  ...
}:
{
  config.programs.zsh = {
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

  config.programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      global.hide_env_diff = true;
      whitelist.prefix = [ "${config.home.homeDirectory}" ];
    };
  };
}
