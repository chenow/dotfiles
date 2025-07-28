{
  lib,
  config,
  ...
}: {
  options.wezterm = {
    enable = lib.mkEnableOption "Enable wezterm module";
    extraConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Extra configuration for wezterm.";
    };
  };

  config.programs.wezterm = lib.mkIf config.wezterm.enable {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./assets/wezterm.lua + "\n" + config.wezterm.extraConfig + "\n" + "return config";
  };
}
