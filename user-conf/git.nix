{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "chenow";
    userEmail = "antoine.cheneau@outlook.com";

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
    ignores = [
      ".DS_Store"
      ".direnv"
      ".envrc"
      ".vscode"
    ];

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
