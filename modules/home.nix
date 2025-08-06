{
  user,
  host,
  ...
}: {
  home-manager = {
    users.${user} = ./home-manager;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = {
      inherit host;
    };
  };
}
