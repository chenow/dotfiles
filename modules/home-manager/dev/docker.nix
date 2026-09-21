{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.my.dev.docker;
in {
  options.my.dev.docker = {
    enable = mkEnableOption "Docker with Colima";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      docker
      docker-compose
    ];

    # Uncomment when available in stable versions
    services.colima.enable = true;
  };
}
