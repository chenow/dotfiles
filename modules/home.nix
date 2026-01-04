{
  user,
  host,
  lib,
  ...
}: {
  # Expose Home Manager module options at the top-level (host) namespace so
  # we can keep identical option paths between nix-darwin integrated and
  # standalone home-manager flakes (e.g. `awscli.enable = true;`).
  # Each alias maps `<name>` -> `home-manager.users.<user>.<name>`.
  imports = [
    (lib.mkAliasOptionModule ["additional"] ["home-manager" "users" user "additional"])
    (lib.mkAliasOptionModule ["awscli"] ["home-manager" "users" user "awscli"])
    (lib.mkAliasOptionModule ["direnv"] ["home-manager" "users" user "direnv"])
    (lib.mkAliasOptionModule ["ssh"] ["home-manager" "users" user "ssh"])
    (lib.mkAliasOptionModule ["zsh"] ["home-manager" "users" user "zsh"])
    (lib.mkAliasOptionModule ["vscodium"] ["home-manager" "users" user "vscodium"])
    (lib.mkAliasOptionModule ["dotfiles"] ["home-manager" "users" user "dotfiles"])
    (lib.mkAliasOptionModule ["git"] ["home-manager" "users" user "git"])
    (lib.mkAliasOptionModule ["wezterm"] ["home-manager" "users" user "wezterm"])
    (lib.mkAliasOptionModule ["home"] ["home-manager" "users" user "home"])
    (lib.mkAliasOptionModule ["docker"] ["home-manager" "users" user "docker"])
    (lib.mkAliasOptionModule ["kiro"] ["home-manager" "users" user "kiro"])
  ];

  home-manager = {
    users.${user} = ./home-manager;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = {
      inherit host;
    };
  };
}
