{
  user,
  lib,
  config,
  ...
}: {
  options = {
    userConfig = lib.mkOption {
      type = lib.types.attrs;
      description = "Alias for home-manager.users.${user} configuration";
      default = {};
    };
  };

  config = {
    # Create the alias: userConfig points to home-manager.users.${user}
    home-manager.users.${user} = config.userConfig;
  };
}
