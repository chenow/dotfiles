{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-be-good
    ];
  };
}
