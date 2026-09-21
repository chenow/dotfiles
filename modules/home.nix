# `extraGroups`: additional `my.<group>` Home Manager option groups defined by
# the consuming flake (e.g. ["amazon"]), aliased like the built-in ones.
extraGroups: {
  user,
  host,
  lib,
  config,
  ...
}: let
  # Expose a Home Manager option group at the top level of the nix-darwin
  # configuration so option paths are identical between nix-darwin hosts and
  # standalone home-manager hosts (e.g. `my.dev.git.enable = true;`).
  #
  # `withPriority = false` (unlike lib.mkAliasOptionModule) forwards the raw
  # definitions, so `mkDefault`/`mkForce` nested inside a group reach Home
  # Manager intact instead of being double-wrapped.
  aliasToUser = path:
    lib.doRename {
      from = path;
      to = ["home-manager" "users" user] ++ path;
      visible = true;
      warn = false;
      use = lib.id;
      withPriority = false;
    };
  aliasedGroups = ["shell" "dev" "editors" "ai"] ++ extraGroups;

  features = import ../lib/features.nix {inherit lib;};
in {
  imports =
    map (g: aliasToUser ["my" g]) aliasedGroups
    ++ [
      (aliasToUser ["my" "enabledFeatures"])
      (aliasToUser ["home"])
    ];

  home-manager = {
    backupFileExtension = "hm-bak";
    extraSpecialArgs = {
      inherit host;
    };
    # `sharedModules` (not `users.<user>.imports`) so the options are visible
    # through `options.home-manager.users.type.getSubOptions []`, which is what
    # nixd uses for Home Manager completion.
    sharedModules = [./home-manager];
    # Report nix-darwin level features (my.macos.*) to Home Manager so
    # `my.enabledFeatures` lists everything enabled on this host.
    users.${user}.my.extraEnabledFeatures =
      features.enabledOptions ["my"] (removeAttrs config.my (aliasedGroups ++ ["enabledFeatures"]));
  };
}
