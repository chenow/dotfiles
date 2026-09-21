# Helpers to introspect which `my.*` features a configuration enables.
{lib}: rec {
  # Walk an attribute set and return the paths (as lists) of every `enable = true`.
  # Values that are not attribute sets (lists, strings, derivations) are skipped.
  enabledPaths = prefix: attrs:
    lib.concatLists (lib.mapAttrsToList (
        name: value:
          if name == "enable"
          then lib.optional (value == true) prefix
          else if lib.isAttrs value && !(lib.isDerivation value)
          then enabledPaths (prefix ++ [name]) value
          else []
      )
      attrs);

  # Same, rendered as dotted option paths, sorted.
  enabledOptions = prefix: attrs:
    lib.sort lib.lessThan (map (lib.concatStringsSep ".") (enabledPaths prefix attrs));
}
