{
  pkgs,
  config,
  user,
  ...
}:
{
  environment.variables = {
    BROWSER = "google-chrome";
  };

  environment.sessionVariables = rec {
    GITREPOS = "${config.users.users."${user}".home}/Documents/git";
    DOTFILES = "${GITREPOS}/dotfiles";
  };

  home-manager.users.${user}.home.shellAliases = {
    system-up = "sudo nixos-rebuild switch --flake ${config.environment.sessionVariables.DOTFILES}";
  };
}
