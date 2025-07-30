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
    userConfig = {
      git.enable = true;
      zsh.enable = true;
      ssh.enable = true;
      direnv.enable = true;
      wezterm.enable = true;
      dotfiles.enable = true;
    };

    # Core packages that every host needs
    userConfig.home.packages = with pkgs; [
      fastfetch
      eza
      htop
    ];

    # Common shell aliases
    userConfig.programs.zsh.shellAliases = {
      ll = "eza -la";
      la = "eza -la";
      ls = "eza";
      tree = "eza --tree";
    };
  };
}
