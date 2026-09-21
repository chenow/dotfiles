{
  lib,
  config,
  ...
}: let
  cfg = config.my.macos.hammerspoon;
in {
  options.my.macos.hammerspoon = {
    enable = lib.mkEnableOption "Hammerspoon (installed via Homebrew, init.lua managed by Home Manager)";

    config = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Lua appended to ~/.hammerspoon/init.lua.";
    };
  };

  config = lib.mkIf cfg.enable {
    my.macos.homebrew = {
      enable = lib.mkDefault true;
      casks = ["hammerspoon"];
    };

    # `home` is aliased to the primary user's Home Manager config (see ../home.nix).
    home.file.".hammerspoon/init.lua".text = cfg.config;
  };
}
