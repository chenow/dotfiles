# Home Manager modules, grouped by concern. Every module is opt-in through
# `my.<group>.<feature>.enable`; nothing is applied by default.
{...}: {
  imports = [
    ./features.nix
    ./shell
    ./dev
    ./editors
    ./ai
  ];
}
