{
  config,
  lib,
  ...
}: let
  cfg = config.my.shell.zsh;
in {
  options.my.shell.zsh = {
    enable = lib.mkEnableOption "Zsh with oh-my-zsh, autosuggestions and syntax highlighting";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "robbyrussell";
      description = "oh-my-zsh theme to use.";
    };

    initContent = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Content to add to the zshrc file.";
    };

    shellAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Extra Zsh shell aliases to add (syntactic sugar for programs.zsh.shellAliases).";
    };

    completions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Additional oh-my-zsh plugins to enable (used for completions).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.shell.enableZshIntegration = true;

    programs.zsh = {
      dotDir = "${config.xdg.configHome}/zsh";
      enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins =
          [
            "git"
            "docker"
            "macos"
            "brew"
          ]
          ++ cfg.completions;
        theme = cfg.theme;
      };
      initContent = ''
        echo "Welcome to Oh My Zsh managed by Home Manager!"
        ${cfg.initContent}
      '';
      shellAliases = cfg.shellAliases;
    };
  };
}
