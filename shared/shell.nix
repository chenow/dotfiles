{
  pkgs,
  config,
  lib,
  ...
}:
{
  environment.variables = {
    TERMINAL = "wezterm";
    EDITOR = "nvim";
  };
}
