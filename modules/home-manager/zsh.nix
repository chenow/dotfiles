{
  config,
  lib,
  ...
}: {
  options.zsh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Zsh in terminal.";
    };

    theme = lib.mkOption {
      type = lib.types.str;
      default = "robbyrussell";
      description = "Zsh theme to use.";
    };

    initContent = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Content to add to the zshrc file.";
    };
    shellAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Extra Zsh shell aliases to add (syntactic sugar for programs.zsh.shellAliases).";
    };
  };

  config.programs.zsh = lib.mkIf config.zsh.enable {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "macos"
        "brew"
        "aws"
      ];
      theme = config.zsh.theme;
    };
    initContent = ''
      echo "Welcome to Oh My Zsh managed by Home Manager!"
      ${config.zsh.initContent}
    '';
    shellAliases = config.zsh.shellAliases;
  };
}
