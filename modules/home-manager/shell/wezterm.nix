{
  lib,
  config,
  ...
}: let
  cfg = config.my.shell.wezterm;
in {
  options.my.shell.wezterm = {
    enable = lib.mkEnableOption "WezTerm terminal emulator";
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra Lua appended to the WezTerm configuration (before `return config`).";
    };
  };

  config.programs.wezterm = lib.mkIf cfg.enable {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ../assets/wezterm.lua + "\n" + cfg.extraConfig + "\n" + "return config";
  };
}
