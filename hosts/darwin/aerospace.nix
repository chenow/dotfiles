{user, ...}: {
  config.home-manager.users.${user}.home.file.".aerospace.toml".source = ./config/aerospace.toml;
}
