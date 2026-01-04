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
      # python
      python3
      uv
      ty
      pyright
      ruff
      # Typescript
      nodejs
      biome
      typescript-language-server
      typescript
      # Utilities
      docker
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

    # For kiro-cli binary
    home.sessionPath = ["$HOME/.local/bin"];

    zsh.shellAliases = {
      k = "kiro-cli";
      k-code = "k chat --agent coding-agent";
      k-aws = "k chat --agent aws-agent";
      k-latex = "k chat --agent latex-agent";
      k-nix = "k chat --agent nix-agent";
      k-cdk = "k chat --agent cdk-agent";
    };

    programs.zsh.initContent = ''
      . ${config.home.homeDirectory}/secrets/load-secrets.sh
      . ${config.home.homeDirectory}/secrets/stripe-secret-key.env
      . ${config.home.homeDirectory}/secrets/context7-api-key.env
    '';
  };
}
