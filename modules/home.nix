{ config, pkgs, ... }:

{
  home.username = "chenow";
  home.homeDirectory = "/Users/chenow";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  home.packages = [ pkgs.git pkgs.fzf pkgs.vim pkgs.direnv ];

  home.file = {
    ".config/direnv/direnv.toml".source = ./confs/direnv.toml;
    ".zshrc".source = ./confs/.zshrc;
  };

  home.sessionVariables = { EDITOR = "code"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
