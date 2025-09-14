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
      matchBlocks = {
        github = {
          hostname = "github.com";
          host = "github.com";
          identityFile = github-key-path;
        };
        "*" = {
          forwardAgent = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          compression = true;
          addKeysToAgent = "no";
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
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
