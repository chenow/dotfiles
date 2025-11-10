{
  lib,
  config,
  ...
}: {
  options.additional = {
    enable = lib.mkEnableOption "Enable additional common programs";
    enablePersonal = lib.mkEnableOption "Enable additional personal programs";
  };
  config = lib.mkIf config.additional.enable (lib.mkMerge [
    {
      xdg.enable = true;

      # Core packages that every host needs
      programs.fzf.enable = true;
      programs.fastfetch.enable = true;
      programs.fd.enable = true;
      programs.eza.enable = true;
      programs.htop.enable = true;
      programs.bat.enable = true;
      programs.ripgrep.enable = true;
      programs.ripgrep-all.enable = true;
      programs.television.enable = true;
    }
    (lib.mkIf config.additional.enablePersonal {
      programs.pgcli.enable = true;
      programs.bun.enable = true;
      programs.uv.enable = true;
    })
  ]);
}
