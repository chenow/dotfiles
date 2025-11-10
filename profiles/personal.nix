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
      python3
      postgresql
      # firebase-tools
      supabase-cli
    ];

    ia-chat.enable = true;
    additional.enablePersonal = true;

    zsh.completions = ["bun" "terraform" "python" "aws" "uv"];
    home.sessionVariables = {
      DRIVE = "/Users/chenow/Library/Mobile Documents/com~apple~CloudDocs";
    };
  };
}
