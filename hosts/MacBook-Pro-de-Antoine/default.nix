{pkgs, ...}: {
  config = {
    profiles = {
      base.enable = true;
      coding.enable = true;
    };
    git.profile = {
      name = "Antoine Chéneau";
      email = "antoine.cheneau@outlook.com";
    };
    environment.systemPackages = with pkgs; [amazon-q-cli raycast];
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
