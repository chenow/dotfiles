{
  pkgs,
  lib,
  system,
  ...
}:

{
  imports = [ (import ./host.nix ({ inherit pkgs system; })) ];
}
