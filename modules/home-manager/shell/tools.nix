{
  lib,
  config,
  ...
}: let
  cfg = config.my.shell.tools;
in {
  options.my.shell.tools.enable = lib.mkEnableOption "everyday CLI tools (fzf, fd, eza, bat, ripgrep, btop, htop, fastfetch)";

  config = lib.mkIf cfg.enable {
    xdg.enable = true;

    home.shellAliases = {
      ls = "eza";
      ll = "eza -la";
      la = "eza -la";
      tree = "eza --tree";
    };

    programs.fzf.enable = true;
    programs.fastfetch.enable = true;
    programs.fd.enable = true;
    programs.eza.enable = true;
    programs.htop.enable = true;
    programs.bat.enable = true;
    programs.ripgrep.enable = true;
    programs.ripgrep-all.enable = true;
    programs.btop = {
      enable = true;
      settings = {
        graph_symbol = "block";
        mem_graphs = false; # This removes the historical line graph
        proc_sorting = "memory"; # Starts btop sorted by RAM usage
      };
    };
  };
}
