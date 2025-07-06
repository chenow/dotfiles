{
  inputs,
  user,
  pkgs,
  ...
}: {
  # home-manager = {
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   extraSpecialArgs = {
  #     inherit inputs user;
  #   };
  #   users.${user}.home = {
  #     username = user;
  #     homeDirectory = "/Users/${user}";
  #     shell = pkgs.zsh;
  #     isHidden = false;
  #     stateVersion = "24.05"; # Check Home Manager release notes before updating

  #     # Checks version mismatches between Nixpkgs and Home Manager.
  #     enableNixpkgsReleaseCheck = true;
  #   };

  system.primaryUser = user;

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs user;
    };
    users.${user}.home = {
      username = user;
      homeDirectory = "/Users/${user}";
      stateVersion = "24.05"; # Check Home Manager release notes before updating

      # Checks version mismatches between Nixpkgs and Home Manager.
      enableNixpkgsReleaseCheck = true;
    };
  };
}
