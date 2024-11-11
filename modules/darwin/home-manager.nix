{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}:

let
  user = "chenow";
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix { };
    onActivation.cleanup = "zap";
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        home = {
          enableNixpkgsReleaseCheck = false;
          packages = pkgs.callPackage ./packages.nix { };
          file = lib.mkMerge [
            sharedFiles
            additionalFiles
          ];

          stateVersion = "24.05";

          sessionVariables = {
            GITREPOS = "/Users/${config.home.username}/Documents/git";
            DOTFILES = "${config.home.sessionVariables.GITREPOS}/dotfiles";
            TERMINAL = "wezterm";
          };

          shellAliases = {
            shell = "docker compose run --rm shell";
            ga = "git add .";
            gck = "git checkout";
            grc = "git rebase --continue";
            gski = "git stash --keep-index";
            system-up = "cd ${config.home.sessionVariables.DOTFILES} && nix run .#build-switch";
          };
        };
        programs = { } // import ../shared/home-manager.nix { inherit config pkgs lib; };
      };
  };
}           

