{
  lib,
  config,
  ...
}: {
  options.github = {
    enable = lib.mkEnableOption "Enable GitHub integration";
  };

  config = lib.mkIf config.github.enable {
    programs.gh.enable = true;
  };
}
