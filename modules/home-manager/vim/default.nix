{lib, ...}: {
  options.vim = {
    enable = lib.mkEnableOption "Enable Vim/Neovim configuration";
  };

  imports = [
    ./neovim.nix
    ./completion.nix
  ];
}
