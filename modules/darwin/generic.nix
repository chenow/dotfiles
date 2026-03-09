{
  pkgs,
  user,
  ...
}: {
  programs.zsh.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };

  nix = {
    package = pkgs.nix;
    enable = true;
    settings = {
      allowed-users = ["${user}"];
      trusted-users = [
        "@admin"
        "${user}"
      ];
      # Only the default cache is queried globally
      substituters = ["https://cache.nixos.org/"];
      # Whitelisted caches — activated per-flake via nixConfig.extra-substituters
      trusted-substituters = [
        "https://nix-community.cachix.org/"
        "https://cache.numtide.com"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
      experimental-features = ["nix-command" "flakes"];
      accept-flake-config = true;
    };
  };
}
