{
  lib,
  pkgs,
  config,
  ...
}: let
  github-key-path = "~/.ssh/github.id_rsa";
in {
  options.ssh.enable = lib.mkEnableOption "SSH configuration";

  config = lib.mkIf config.ssh.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        github = {
          Host = "github.com";
          HostName = "github.com";
          IdentityFile = github-key-path;
        };
        "*" = {
          ForwardAgent = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          Compression = true;
          AddKeysToAgent = "no";
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/cm-%C";
          ControlPersist = "no";
        };
      };
    };

    home.activation = {
      generateGithubSshKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -f ${github-key-path} ]; then
              $DRY_RUN_CMD mkdir -p ~/.ssh
              $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -f ${github-key-path} -N ""
                echo "created ssh key at ${github-key-path}"
         fi
      '';
    };
  };
}
