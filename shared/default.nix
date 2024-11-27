{
  config,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./generic.nix
    ./neovim.nix
    ./packages.nix
    ./shell.nix
  ];

  home-manager.users.${user} = import ./home-manager;
}
