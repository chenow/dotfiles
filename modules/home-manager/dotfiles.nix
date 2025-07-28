{
  lib,
  pkgs,
  config,
  host,
  ...
}: {
  options.dotfiles = {
    enable = lib.mkEnableOption "Setup dotfiles repository locally.";
    git-url = lib.mkOption {
      type = lib.types.str;
      default = "ssh://git.amazon.com:2222/pkg/ACheneauDotfiles";
      description = "URL of the dotfiles repository.";
    };
    dir-path = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/git/dotfiles";
      description = "Path to the dotfiles repository.";
    };
  };

  config = lib.mkIf config.dotfiles.enable {
    home.packages = with pkgs; [
      nixd
      alejandra
    ];

    programs.zsh.shellAliases = {
      user-up = "home-manager switch --flake \"${config.dotfiles.dir-path}#${host}\"";
      cdd = "cd ${config.dotfiles.dir-path}";
    };

    programs.zsh.sessionVariables = {
      WORKPLACE = "${config.home.homeDirectory}/workplace";
      DOTFILES = "${config.dotfiles.dir-path}";
    };

    home.activation.dotfiles = lib.hm.dag.entryAfter ["installPackages"] ''
      if [ ! -d "${config.dotfiles.dir-path}" ]; then
        mkdir -p "${config.dotfiles.dir-path}"
        ${pkgs.git}/bin/git clone "${config.dotfiles.git-url}" "${config.dotfiles.dir-path}"
        printf "Cloned dotfiles repository at ${config.dotfiles.dir-path}\n"
      fi
    '';
  };
}
