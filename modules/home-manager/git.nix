{
  lib,
  pkgs,
  config,
  ...
}: {
  options.git = {
    enable = lib.mkEnableOption "Git configuration";
    profile = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Git user name";
      };
      email = lib.mkOption {
        type = lib.types.str;
        description = "Git user email";
      };
    };
    defaultBranch = lib.mkOption {
      type = lib.types.str;
      description = "Default branch name";
      default = "main";
    };
  };
  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;

      extraConfig = {
        init.defaultBranch = config.git.defaultBranch;
        merge.conflictstyle = "diff3";
        diff.algorithm = "patience";
        rerere.enabled = true;
        color.ui = "auto";
        push.default = "simple";
        pull.rebase = true;
        core.editor = "vim";
      };

      delta = {
        enable = true;
        options.dark = true;
        options.line-numbers = true;
        options.hyperlink = true;
        options.navigate = true;
      };

      userName = config.git.profile.name;
      userEmail = config.git.profile.email;
      ignores = [
        "*.swp"
        ".DS_Store"
        ".direnv"
        ".envrc"
        ".vscode"
        ".factorypath"
        ".run"
        ".kiro"
        "cdk.context.json"
      ];

      aliases = {
        autofixup = "!f() { \
        commit=$(git log --oneline | ${pkgs.fzf}/bin/fzf --preview 'git show --color=always {1}' | cut -d' ' -f1); \
        if [ -n \"$commit\" ]; then \
            git commit --fixup=$commit && \
            GIT_SEQUENCE_EDITOR=: git rebase -i --autostash --autosquash $commit~1; \
        else \
            echo \"No commit selected\"; \
        fi; \
    }; f";
        dag = "log --graph --format='format:%C(yellow)%h%C(reset) %C(blue)''\"%an''\" <%ae>%C(reset) %C(magenta)%cr%C(reset)%C(auto)%d%C(reset)%n%s' --date-order";
      };
    };

    programs.zsh.shellAliases = {
      gck = "git checkout";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      ga = "git add";
      grc = "git rebase --continue";
      gri = "git rebase -i HEAD~10";
      gb = "git branch";
      gcm = "git commit -m";
      gca = "git commit --amend";
    };
  };
}
