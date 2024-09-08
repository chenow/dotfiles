{
  nixpkgs,
  flake-utils,
  pre-commit-env,
}:

flake-utils.lib.eachDefaultSystem (
  system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
    pre-commit-lib = import "${pre-commit-env}/libs/dev-shell.nix" { inherit pkgs; };
  in
  {
    devShells = {
      default = pre-commit-lib.mkDevShell { };
    };
  }
)
