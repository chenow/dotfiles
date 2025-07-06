{
  config,
  lib,
  ...
}: {
  options.direnv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable direnv.";
    };
  };

  config.programs.direnv = lib.mkIf config.direnv.enable {
    enable = true;
    enableZshIntegration = config.zsh.enable;
    silent = true;
    nix-direnv.enable = true;
    config = {
      global.hide_env_diff = true;
      whitelist.prefix = ["${config.home.homeDirectory}"];
    };
  };
}
