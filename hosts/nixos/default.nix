{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../../shared
    ../../modules/nixos
    ./hardware-configuration.nix
  ];
}
