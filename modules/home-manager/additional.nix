{config, ...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = config.zsh.enable;
  };
  xdg.enable = true;
}
