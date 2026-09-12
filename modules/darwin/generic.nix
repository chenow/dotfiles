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

    # Scheduled maintenance (launchd)
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
    };

    # Weekly store deduplication (safe on APFS)
    optimise.automatic = true;

    settings = {
      allowed-users = ["${user}"];
      trusted-users = [
        "@admin"
        "${user}"
      ];

      # Cache & substituters
      substituters = ["https://cache.nixos.org/"];
      trusted-substituters = self.lib.caches.substituters;
      trusted-public-keys =
        [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ]
        ++ self.lib.caches.trusted-public-keys;

      # Modern features
      experimental-features = ["nix-command" "flakes"];
      accept-flake-config = true;
      eval-cache = true;
      warn-dirty = false;
    };
  };
}
