{config, ...}: {
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
        "macos"
        "direnv"
        "brew"
      ];
      theme = "robbyrussell";
    };
    initContent = ''
      echo "Welcome to Oh My Zsh managed by Home Manager!"
    '';
  };

  config.programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    silent = true;
    nix-direnv.enable = true;
    config = {
      global.hide_env_diff = true;
      whitelist.prefix = ["${config.home.homeDirectory}"];
    };
  };
}
