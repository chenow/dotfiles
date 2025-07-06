{user, ...}: {
  config = {
    home-manager.users.${user} = import ./home-manager;
  };
}
