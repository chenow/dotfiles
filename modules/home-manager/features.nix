# Read-only summary of every `my.*.enable = true` in this configuration.
#
# Home Manager level: `my.enabledFeatures` walks the HM `my.*` tree. On
# nix-darwin hosts, ../home.nix appends the Darwin-level features
# (my.macos.*) through `my.extraEnabledFeatures`, so the list is
# complete wherever you read it:
#
#   nix eval --json .#darwinConfigurations.<host>.config.my.enabledFeatures
#   nix eval --json .#homeConfigurations.<host>.config.my.enabledFeatures
#   features            # shell alias on the machine, same list
{
  lib,
  pkgs,
  config,
  ...
}: let
  features = import ../../lib/features.nix {inherit lib;};
  # Skip the two summary options themselves while walking.
  tree = removeAttrs config.my ["enabledFeatures" "extraEnabledFeatures"];
in {
  options.my = {
    enabledFeatures = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      readOnly = true;
      description = "Sorted list of every enabled `my.*` feature (dotted option paths).";
    };
    extraEnabledFeatures = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      internal = true;
      description = "Enabled features not visible from this module system (set by the nix-darwin layer).";
    };
  };

  config = {
    my.enabledFeatures = lib.sort lib.lessThan (lib.unique (features.enabledOptions ["my"] tree ++ config.my.extraEnabledFeatures));

    programs.zsh.shellAliases.features = "cat ${pkgs.writeText "enabled-features" (lib.concatMapStrings (f: f + "\n") config.my.enabledFeatures)}";
  };
}
