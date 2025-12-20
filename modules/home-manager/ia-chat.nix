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
      gemini-cli
      pyright
      ruff
      biome
      typescript-language-server
      typescript
    ];
    programs.uv.enable = true;

    home.file.".kiro/agents" = {
      source = ./assets/kiro/agents;
      recursive = true;
    };
    home.file.".kiro/resources" = {
      source = ./assets/kiro/resources;
      recursive = true;
    };

    zsh.shellAliases = {
      k = "kiro-cli";
      k-code = "k chat --agent coding-agent";
      k-aws = "k chat --agent aws-agent";
      k-latex = "k chat --agent latex-agent";
      k-nix = "k chat --agent nix-agent";
    };

    programs.zsh.initContent = ''
      . ${config.home.homeDirectory}/secrets/load-secrets.sh
    '';
  };
}
