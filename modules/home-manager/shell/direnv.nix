{
  config,
  lib,
  ...
}: let
  cfg = config.my.shell.direnv;
in {
  options.my.shell.direnv.enable = lib.mkEnableOption "direnv with nix-direnv";

  config.programs.direnv = lib.mkIf cfg.enable {
    enable = true;
    enableZshIntegration = config.my.shell.zsh.enable;
    silent = true;
    nix-direnv.enable = true;
    config = {
      global.hide_env_diff = true;
      whitelist.prefix = ["${config.home.homeDirectory}"];
    };
  };
}
