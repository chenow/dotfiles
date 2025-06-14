{...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  xdg.enable = true;
  programs.vscode = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
  };
}
