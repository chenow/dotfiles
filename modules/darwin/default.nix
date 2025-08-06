{
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [
    ./generic.nix
    ./homebrew.nix
    ./system.nix
    ./user.nix
  ];

  environment.systemPackages = [
    pkgs.nixd
    pkgs.alejandra
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  system.primaryUser = user;
}
