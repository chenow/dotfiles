{pkgs, ...}: let
  name = "Antoine Chéneau";
  user = "chenow";
  email = "antoine.cheneau@outlook.com";
in {
  programs.git = {
    enable = true;
    ignores = [
      "*.swp"
      ".DS_Store"
      ".direnv"
      ".envrc"
      ".vscode"
    ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
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
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      # TODO: add GPG key
      commit.gpgsign = false;
      pull.rebase = true;
    };
  };
}
