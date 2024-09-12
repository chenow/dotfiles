{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      vim-be-good
    ];
  };
}
