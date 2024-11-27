{
  pkgs,
  lib,
  config,
  user,
  inputs,
  ...
}:
{
  imports = [
    ../shared
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs user;
    };
    users.${user}.home = {
      username = user;
      stateVersion = "24.05"; # Check Home Manager release notes before updating

      # Checks version mismatches between Nixpkgs and Home Manager.
      enableNixpkgsReleaseCheck = true;
    };
  };
}
