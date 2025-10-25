{
  lib,
  pkgs,
  config,
  ...
}: {
  options.profiles.personal = {
    enable = lib.mkEnableOption "Personal profile";
  };

  config = lib.mkIf config.profiles.personal.enable {
    home.packages = with pkgs; [
      terraform
      awscli2
      python3
      postgresql
      # firebase-tools
      supabase-cli
    ];

    programs.pgcli.enable = true;
    programs.bun.enable = true;
    programs.uv.enable = true;

    ia-chat.enable = true;

    zsh.completions = ["bun" "terraform" "python" "aws" "uv"];
    home.sessionVariables = {
      DRIVE = "/Users/chenow/Library/Mobile Documents/com~apple~CloudDocs";
    };
  };
}
