{
  lib,
  pkgs,
  config,
  ...
}: {
  options.profiles.personal = {
    enable = lib.mkEnableOption "Personal profile";
  };

  config = lib.mkIf config.profiles.personal.enable {
    home.packages = with pkgs; [
      bun
      terraform
      awscli2
      python313Full
      uv
    ];
  };
}
