{
  pkgs,
  config,
  lib,
  user,
  ...
}:
{
  home-manager.users.${user}.home.homeDirectory = "/Users/${user}";

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
}
