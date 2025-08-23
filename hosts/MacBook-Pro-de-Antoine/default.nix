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
          accountId = "427609183967";
          region = "eu-west-3";
        }
      ];
    };
  };
}
