{user, ...}: {
  home-manager.users.${user}.git.profile = {
    name = "Antoine Chéneau";
    email = "antoine.cheneau@outlook.com";
  };
}
