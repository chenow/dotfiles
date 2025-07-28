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

    # Core packages that every host needs
    home.packages = with pkgs; [
      fastfetch
      eza
      htop
    ];

    # Common shell aliases
    programs.zsh.shellAliases = {
      ll = "eza -la";
      la = "eza -la";
      ls = "eza";
      tree = "eza --tree";
    };

    # Install wezterm
    wezterm.enable = true;
    dotfiles.enable = true;
  };
}
