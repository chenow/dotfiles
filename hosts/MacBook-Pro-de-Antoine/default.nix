{...}: {
  config = {
    profiles = {
      base.enable = true;
      personal.enable = true;
    };
    hammerspoon.enable = true;
    docker.enable = true;
    git.profile = {
      name = "Antoine Chéneau";
      email = "antoine.cheneau@outlook.com";
    };
    awscli = {
      enable = true;
      extraConfig = {
        "profile galipet" = {
          region = "eu-west-3";
          output = "json";
          login_session = "arn:aws:iam::437064342433:user/antoine.cheneau@outlook.com";
        };
      };
      accounts = [
        {
          name = "galipet-personal";
          accountId = "318361291054";
          region = "eu-west-1";
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
