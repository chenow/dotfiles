{...}: {
  imports = [
    ../default-settings.nix
    ./hardware-configuration.nix
    ./configuration.nix
    ./packages.nix
    ./shell.nix
  ];
}
