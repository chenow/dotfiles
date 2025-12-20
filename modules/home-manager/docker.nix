{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.docker;
in {
  options.docker = {
    enable = mkEnableOption "Docker with Colima";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      docker
      docker-compose
    ];

    services.colima.enable = true;
  };
}
