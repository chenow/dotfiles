{
  pkgs,
  self,
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
      substituters = ["https://cache.nixos.org/"];
      trusted-substituters = self.lib.caches.substituters;
      trusted-public-keys =
        ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="]
        ++ self.lib.caches.trusted-public-keys;
      experimental-features = ["nix-command" "flakes"];
      accept-flake-config = true;
    };
  };
}
