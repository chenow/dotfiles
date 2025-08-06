{...}: {
  profiles = {
    base.enable = true;
    coding.enable = true;
  };

  config = {
    git.profile = {
      name = "Antoine Chéneau";
      email = "antoine.cheneau@outlook.com";
    };

    vscode.enable = true;
    awscli.enable = true;
  };
}
