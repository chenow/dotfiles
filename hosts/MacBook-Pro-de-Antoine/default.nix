{...}: {
  userConfig = {
    git.profile = {
      name = "Antoine Chéneau";
      email = "antoine.cheneau@outlook.com";
    };

    profiles = {
      base.enable = true;
      coding.enable = true;
    };
    vscode.enable = true;
    awscli.enable = true;
  };
}
