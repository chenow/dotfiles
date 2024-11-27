{
  pkgs,
  config,
  lib,
  user,
  ...
}:
{
  imports = [
    ../default-settings.nix
    ./homebrew.nix
    ./system.nix
    ./shell.nix
    ./user.nix
  ];
}
