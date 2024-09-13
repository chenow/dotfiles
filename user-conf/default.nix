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
    (./wezterm.nix)
    (./git.nix)
  ];
}
