{
  lib,
  pkgs,
  config,
  ...
}: {
  options.profiles.base = {
    enable =
      lib.mkEnableOption "Base profile";
  };

  config = lib.mkIf config.profiles.base.enable {
    # Enable core home-manager functionality
    git.enable = true;
    zsh.enable = true;
    ssh.enable = true;
    direnv.enable = true;
    dotfiles.enable = true;
    wezterm.enable = true;

    # Core packages that every host needs
    programs.fastfetch.enable = true;
    programs.fd.enable = true;
    programs.eza.enable = true;
    programs.htop.enable = true;
    programs.bat.enable = true;
    programs.ripgrep.enable = true;
    programs.ripgrep-all.enable = true;

    # Common shell aliases
    zsh.shellAliases = {
      ll = "${pkgs.eza}/bin/eza -la";
      la = "eza -la";
      ls = "eza";
      tree = "eza --tree";
      shell = "docker compose run --rm shell";
    };
  };
}
