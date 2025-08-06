{...}: {
  config = {
    profiles = {
      base.enable = true;
      coding.enable = true;
    };
    git.profile = {
      name = "Antoine Chéneau";
      email = "antoine.cheneau@outlook.com";
    };

    vscode.enable = true;
    awscli.enable = true;
  };
}
