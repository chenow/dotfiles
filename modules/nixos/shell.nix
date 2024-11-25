{
  pkgs,
  config,
  user,
  ...
}:
{
  environment.variables = {
    EDITOR = "nvim";
    TERMINAL = "wezterm";
    BROWSER = "google-chrome";
  };

  environment.sessionVariables = rec {
    GITREPOS = "${config.users.users."${user}".home}/Documents/git";
    DOTFILES = "${GITREPOS}/dotfiles";
  };

  programs.zsh.shellAliases = {
    system-up = "sudo nixos-rebuild switch --flake ${config.environment.sessionVariables.DOTFILES}";
  };
}
