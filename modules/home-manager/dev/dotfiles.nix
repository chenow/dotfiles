{
  lib,
  pkgs,
  config,
  host,
  inputs,
  ...
}: let
  cfg = config.my.dev.dotfiles;
in {
  options.my.dev.dotfiles = {
    enable = lib.mkEnableOption "Setup dotfiles repository locally.";
    git-url = lib.mkOption {
      type = lib.types.str;
      description = "URL of the repository holding this machine's configuration (cloned on first activation).";
      example = "git@github.com:me/dotfiles.git";
    };
    dir-path = lib.mkOption {
      type = lib.types.str;
      description = "Where to clone the repository; also the flake used by the `user-up`/`system-up` aliases.";
      example = "/Users/me/git/dotfiles";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nixd
      alejandra
    ];

    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    programs.zsh.shellAliases = {
      user-up = "home-manager switch --flake \"${cfg.dir-path}#${host}\"";
      system-up = "sudo darwin-rebuild switch --flake \"${cfg.dir-path}#${host}\"";
      cdd = "cd ${cfg.dir-path}";
    };

    programs.zsh.sessionVariables = {
      WORKPLACE = "${config.home.homeDirectory}/workplace";
      DOTFILES = "${cfg.dir-path}";
    };

    home.activation.dotfiles = lib.hm.dag.entryAfter ["generateGithubSshKey"] ''
      if [ ! -d "${cfg.dir-path}" ]; then
        mkdir -p "${cfg.dir-path}"
        PATH="${pkgs.openssh}/bin:$PATH" ${pkgs.git}/bin/git clone "${cfg.git-url}" "${cfg.dir-path}"
        printf "Cloned dotfiles repository at ${cfg.dir-path}\n"
      fi
    '';
  };
}
