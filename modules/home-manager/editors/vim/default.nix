{lib, ...}: {
  options.my.editors.vim = {
    enable = lib.mkEnableOption "Enable Vim/Neovim configuration";
  };

  imports = [
    ./neovim.nix
    ./completion.nix
  ];
}
