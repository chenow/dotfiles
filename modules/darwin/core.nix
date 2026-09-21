# Unconditional plumbing required by every nix-darwin host built with
# `mkDarwinSystem`: user account, Home Manager wiring, flakes support.
# Anything opinionated lives behind a `my.macos.*` option.
{
  self,
  inputs,
  user,
  pkgs,
  ...
}: {
  system.primaryUser = user;

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # Needed so that zsh sessions get the nix-darwin PATH.
  programs.zsh.enable = true;

  nix = {
    package = pkgs.nix;
    enable = true;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;
  system.stateVersion = 7;
  system.configurationRevision = self.rev or self.dirtyRev or null;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs user;
    };
    users.${user}.home = {
      username = user;
      homeDirectory = "/Users/${user}";
      stateVersion = "26.05"; # Check Home Manager release notes before updating

      # Checks version mismatches between Nixpkgs and Home Manager.
      enableNixpkgsReleaseCheck = true;
    };
  };
}
