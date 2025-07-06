{
  lib,
  config,
  pkgs,
  ...
}: let
  defaultLuaConfig = builtins.readFile ./config/wezterm.lua;
in {
  options.wezterm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable WezTerm terminal emulator.";
    };
    extraLuaConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Extra Lua configuration for WezTerm, added at the beginning of the file.";
    };
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.wezterm;
      description = "WezTerm package to use.";
    };
  };

  config.programs.wezterm = lib.mkIf config.wezterm.enable {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = config.zsh.enable;
    extraConfig = config.wezterm.extraLuaConfig + "\n" + defaultLuaConfig;
    package = config.wezterm.package;
  };
}
