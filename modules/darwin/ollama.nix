{
  pkgs,
  config,
  lib,
  user,
  ...
}: let
  ollama = pkgs.ollama;
in {
  config = lib.mkIf config.home-manager.users.${user}.llm-agents.enable {
    # Ollama server — starts at login, restarts on crash
    launchd.user.agents.ollama = {
      command = "${ollama}/bin/ollama serve";
      environment.HOME = "/Users/${user}";
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/ollama.log";
        StandardErrorPath = "/tmp/ollama.err";
      };
    };

    # One-shot: pull models after ollama starts
    launchd.user.agents.ollama-pull = {
      script = ''
        # Wait for ollama to be ready
        for i in $(seq 1 30); do
          ${ollama}/bin/ollama list >/dev/null 2>&1 && break
          sleep 1
        done
        ${ollama}/bin/ollama pull qwen2.5-coder:7b
        ${ollama}/bin/ollama pull qwen2.5-coder:0.5b
        ${ollama}/bin/ollama pull glm-4.7-flash
        ${ollama}/bin/ollama pull devstral
      '';
      environment.HOME = "/Users/${user}";
      serviceConfig = {
        RunAtLoad = true;
        LaunchOnlyOnce = true;
        StandardOutPath = "/tmp/ollama-pull.log";
        StandardErrorPath = "/tmp/ollama-pull.err";
      };
    };
  };
}
