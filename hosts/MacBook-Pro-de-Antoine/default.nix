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
    awscli = {
      enable = true;
      accounts = [
        {
          name = "mcp-learning";
          accountId = "081373342303";
        }
        {
          name = "trophenix";
          accountId = "857360183350";
          region = "eu-west-3";
        }
      ];
    };
  };
}
