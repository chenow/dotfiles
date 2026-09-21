# my.shell.* : terminal experience (zsh, direnv, CLI tools, terminal emulator)
{...}: {
  imports = [
    ./zsh.nix
    ./direnv.nix
    ./tools.nix
    ./television.nix
    ./wezterm.nix
  ];
}
