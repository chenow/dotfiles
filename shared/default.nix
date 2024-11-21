{ config, pkgs, ... }:

{
  imports = [
    ./generic.nix
    ./neovim.nix
    ./packages.nix
  ];
}
