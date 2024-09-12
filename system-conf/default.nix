{
  pkgs,
  lib,
  system,
  ...
}:

{
  imports = [
    (import ./host.nix ({ inherit pkgs system; }))
    (import ./finder.nix)
    (import ./homebrew.nix)
    (import ./additional.nix)
  ];
}
