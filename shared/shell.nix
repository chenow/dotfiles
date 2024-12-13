{
  pkgs,
  config,
  lib,
  user,
  ...
}: {
  config.environment.variables = {
    TERMINAL = "wezterm";
    EDITOR = "nvim";
  };

  config.home-manager.users.${user}.home.shellAliases = {
    gck = "git checkout";
    grc = "git rebase --continue";
    gski = "git stash --keep-index";
  };
}
