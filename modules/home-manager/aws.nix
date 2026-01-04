{
  config,
  lib,
  ...
}: let
  cfg = config.awscli;
in {
  options.awscli = {
    enable = lib.mkEnableOption "Enable AWS CLI support.";

    extraConfig = lib.mkOption {
      type = with lib.types; attrsOf anything;
      default = {};
      description = "Extra AWS CLI configuration sections to add to the config file.";
      example = {
        "profile galipet" = {
          region = "eu-west-2";
          output = "json";
        };
      };
    };

    accounts = lib.mkOption {
      type = with lib.types;
        listOf (submodule {
          options = {
            name = lib.mkOption {
              type = str;
              description = "Short name identifying the account; used in profile and sso-session names.";
              example = "mcp-learning";
            };

            accountId = lib.mkOption {
              type = str;
              description = "The AWS account ID.";
              example = "123456789012";
            };

            role = lib.mkOption {
              type = str;
              description = "Default role name to assume via SSO (sso_role_name).";
              default = "AdministratorAccess";
            };

            region = lib.mkOption {
              type = str;
              description = "Default region for this profile.";
              default = "eu-west-1";
            };
            ssoStartUrl = lib.mkOption {
              type = str;
              description = "The URL that your organization uses to access the AWS SSO user portal.";
              default = "https://d-9367a61fa9.awsapps.com/start/#";
            };
          };
        });
      default = [];
      description = ''
        List of AWS accounts to generate SSO sessions and profiles for. For each entry,
        the module will create:
          - a profile named "profile <name>"
          - a sso-session named "sso-session <name>"
        using the provided accountId, defaultRole, and defaultRegion.
      '';
    };
  };

  config.programs.awscli = lib.mkIf cfg.enable {
    enable = true;
    settings = let
      # Build a flat list of named attrs for both profiles and sso-sessions
      entries =
        lib.concatMap (
          acct: [
            {
              name = "profile ${acct.name}";
              value = {
                sso_session = acct.name;
                sso_account_id = acct.accountId;
                sso_role_name = acct.role;
                region = acct.region;
                output = "json";
              };
            }
            {
              name = "sso-session ${acct.name}";
              value = {
                sso_start_url = acct.ssoStartUrl;
                sso_region = acct.region;
                sso_registration_scopes = "sso:account:access";
              };
            }
          ]
        )
        cfg.accounts;
    in
      builtins.listToAttrs entries // cfg.extraConfig;
  };
}
