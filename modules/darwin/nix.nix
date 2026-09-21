{
  lib,
  config,
  self,
  user,
  ...
}: let
  cfg = config.my.macos.nix;
in {
  options.my.macos.nix = {
    enable = lib.mkEnableOption "Nix daemon tuning: scheduled GC, store optimisation, binary caches, trusted users";

    allowUnfree = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Allow unfree packages (also applies to Home Manager since useGlobalPkgs is set).";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config = {
      allowUnfree = cfg.allowUnfree;
      allowBroken = true;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };

    nix = {
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

        accept-flake-config = true;
        eval-cache = true;
        warn-dirty = false;
      };
    };
  };
}
