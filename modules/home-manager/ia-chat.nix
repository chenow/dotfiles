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
      uv
      python313Packages.fastmcp
    ];
    programs.uv.enable = true;

    home.file.".kiro/agents" = {
      source = ./assets/kiro/agents;
      recursive = true;
    };

    home.file.".gemini/agents" = {
      source = ./assets/gemini;
      recursive = true;
    };

    zsh.shellAliases = {
      k = "kiro-cli";
      k-code = "k chat --agent coding-agent";
      k-aws = "k chat --agent aws-agent";
      k-latex = "k chat --agent latex-agent";
    };

    programs.zsh.initContent = ''
      . ${config.home.homeDirectory}/secrets/load-secrets.sh
    '';
  };
}
