{...}: {
  profiles = {
    base.enable = true;
    coding.enable = true;
  };

  userConfig = {
    git.profile = {
      name = "Antoine Chéneau";
      email = "antoine.cheneau@outlook.com";
    };

    wezterm.enable = true;
    ssh.enable = true;
    zsh.enable = true;
    vscode.enable = true;
    awscli.enable = true;
    git.enable = true;
    dotfiles.enable = true;
    direnv.enable = true;
  };
}
