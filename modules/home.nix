{user, ...}: {
  config = {
    home-manager.users.${user} = import ./home-manager;
    home-manager.backupFileExtension = "hm-bak";
  };
}
