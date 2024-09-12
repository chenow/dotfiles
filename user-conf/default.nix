{
  pkgs,
  config,
  lib,
  ...
}:

{
  imports = [
    (./home.nix)
    (./neovim.nix)
  ];
}
