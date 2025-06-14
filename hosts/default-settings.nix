{
  pkgs,
  user,
  inputs,
  ...
}: {
  imports = [
    ../shared
  ];

  environment.systemPackages = [
    pkgs.nixd
    pkgs.alejandra
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

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
