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
    additional.enable = true;

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
