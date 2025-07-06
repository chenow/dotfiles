{
  description = "A test flake";
  inputs = {
    dotfiles.url = "path:../";
  };
  outputs = {dotfiles, ...}: let
    treefmtConfig = import ./treefmt.nix;
  in {
    # Formatters configuration
    formatter = dotfiles.lib.eachSystem (system: dotfiles.lib.makeFormatter system treefmtConfig);
  };
}
