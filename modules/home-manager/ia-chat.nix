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
      uv
      docker
      python313
      python313Packages.fastmcp
    ];

    zsh.shellAliases = {
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
