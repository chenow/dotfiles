{
  config,
  pkgs,
  lib,
  user,
  ...
}:
{

  home-manager.users.${user}.home = {
    sessionVariables = rec {
      GITREPOS = "${config.users.users."${user}".home}/Documents/git";
      DOTFILES = "${GITREPOS}/dotfiles";
    };
    shellAliases = {
      system-up = "darwin-rebuild switch --flake ${
        config.home-manager.users.${user}.home.sessionVariables.DOTFILES
      }";
    };
  };
}