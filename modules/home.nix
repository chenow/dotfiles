{
  user,
  host,
  ...
}: {
  home-manager = {
    users.${user} = import ./home-manager;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = {
      inherit host;
    };
  };
}
