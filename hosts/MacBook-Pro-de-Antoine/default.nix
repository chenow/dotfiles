{...}: {
  config = {
    profiles = {
      base.enable = true;
      personal.enable = true;
    };
    hammerspoon.enable = true;
    git.profile = {
      name = "Antoine Chéneau";
      email = "antoine.cheneau@outlook.com";
    };
    awscli = {
      enable = true;
      accounts = [
        {
          name = "mcp-learning";
          accountId = "081373342303";
        }
        {
          name = "trophenix";
          accountId = "770688009346";
          region = "eu-west-3";
          ssoStartUrl = "https://d-806774b8a1.awsapps.com/start/#";
        }
        {
          name = "personal-management";
          accountId = "901512092184";
          region = "eu-west-1";
        }
      ];
    };
  };
}
