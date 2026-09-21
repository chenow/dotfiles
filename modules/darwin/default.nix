# nix-darwin modules. Only ./core.nix applies unconditionally; every other
# module is opt-in through `my.macos.<feature>.enable`.
{...}: {
  imports = [
    ./core.nix
    ./nix.nix
    ./defaults.nix
    ./homebrew.nix
    ./hammerspoon.nix
  ];
}
