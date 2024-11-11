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
  imports = [
    ./dock
  ];

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
    onActivation.cleanup = "uninstall";
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

          stateVersion = "23.11";

          sessionVariables = {
            GITREPOS = "/Users/${config.home.username}/Documents/git";
            DOTFILES = "${config.home.sessionVariables.GITREPOS}/dotfiles";
            NIXPKGS_ALLOW_UNFREE = 1;
          };

          shellAliases = {
            shell = "docker compose run --rm shell";
            ga = "git add .";
            gck = "git checkout";
            grc = "git rebase --continue";
            gski = "git stash --keep-index";
            user-up = "home-manager switch --impure --flake ${config.home.sessionVariables.DOTFILES}";
            system-up = "darwin-rebuild switch --impure --flake ${config.home.sessionVariables.DOTFILES}";
          };
        };
        programs = { } // import ../shared/home-manager.nix { inherit config pkgs lib; };

        # Marked broken Oct 20, 2022 check later to remove this
        # https://github.com/nix-community/home-manager/issues/3344
        manual.manpages.enable = false;
      };
  };

  # Fully declarative dock using the latest from Nix Store
  local = {
    dock = {
      enable = true;
      entries = [
        { path = "/Applications/Slack.app/"; }
        { path = "/System/Applications/Messages.app/"; }
        { path = "/System/Applications/Facetime.app/"; }
        { path = "/System/Applications/Music.app/"; }
        { path = "/System/Applications/News.app/"; }
        { path = "/System/Applications/Photos.app/"; }
        { path = "/System/Applications/Photo Booth.app/"; }
        { path = "/System/Applications/TV.app/"; }
        { path = "/System/Applications/Home.app/"; }
        {
          path = "${config.users.users.${user}.home}/.local/share/";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
        {
          path = "${config.users.users.${user}.home}/.local/share/downloads";
          section = "others";
          options = "--sort name --view grid --display stack";
        }
      ];
    };
  };
}
