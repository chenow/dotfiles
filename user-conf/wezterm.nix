{
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./confs/wezterm.lua;
  };
}
