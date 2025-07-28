{
  lib,
  pkgs,
  config,
  ...
}: {
  options.profiles.coding = {
    enable = lib.mkEnableOption "Development profile";
  };

  config = lib.mkIf config.profiles.coding.enable {
    # Development packages
    home.packages = with pkgs; [
      # Core development tools
      nodejs
      python313Full
      uv
    ];
  };
}
