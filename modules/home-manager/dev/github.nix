{
  lib,
  config,
  ...
}: {
  options.my.dev.github = {
    enable = lib.mkEnableOption "Enable GitHub integration";
  };

  config = lib.mkIf config.my.dev.github.enable {
    programs.gh.enable = true;
  };
}
