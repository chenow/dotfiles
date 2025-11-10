{
  pkgs,
  lib,
  config,
  ...
}: {
  options.ia-chat = {
    enable = lib.mkEnableOption "Enable IA Chat service";
  };

  config = lib.mkIf config.ia-chat.enable {
    home.packages = with pkgs; [
      nodejs
      docker
      python313
      python313Packages.fastmcp
      claude-code
      amazon-q-cli
      gemini-cli
    ];
    programs.uv.enable = true;

    zsh.shellAliases = {
      q = "amazon-q";
      q-personal = "q chat --agent personal-agent";
      q-code = "q chat --agent coding-agent";
      q-aws = "q chat --agent aws-agent";
    };

    home.file.".aws/amazonq/cli-agents" = {
      source = ./assets/q-cli-agents;
      recursive = true;
    };
    home.file.".aws/amazonq/ressources" = {
      source = ./assets/ressources;
      recursive = true;
    };

    programs.zsh.initContent = ''
      . ${config.home.homeDirectory}/secrets/load-secrets.sh
    '';
  };
}
