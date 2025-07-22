{
  config,
  lib,
  ...
}: {
  options.awscli = {
    enable = lib.mkEnableOption "Enable AWS CLI support.";
  };

  config.programs.awscli = lib.mkIf config.awscli.enable {
    enable = true;
    settings = {
      "profile mcp-learning" = {
        sso_session = "mcp-learning";
        sso_account_id = "081373342303";
        sso_role_name = "AdministratorAccess";
        region = "eu-west-1";
        output = "json";
      };
      "sso-session mcp-learning" = {
        sso_start_url = "https://d-9367a61fa9.awsapps.com/start/#";
        sso_region = "eu-west-1";
        sso_registration_scopes = "sso:account:access";
      };
    };
  };
}
