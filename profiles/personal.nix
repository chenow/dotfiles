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
      bun
      uv
      terraform
      awscli2
      python313
      postgresql
      firebase-tools
    ];

    ia-chat.enable = true;

    zsh.completions = ["bun" "terraform" "python" "aws" "uv"];
    home.sessionVariables = {
      DRIVE = "/Users/chenow/Library/Mobile Documents/com~apple~CloudDocs";
    };
  };
}
