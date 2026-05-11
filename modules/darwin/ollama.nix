{
  pkgs,
  config,
  lib,
  user,
  ...
}: {
  config = lib.mkIf config.home-manager.users.${user}.llm-agents.enable {
    launchd.user.agents.ollama = {
      command = "${pkgs.ollama}/bin/ollama serve";
      environment = {
        HOME = "/Users/${user}";

        # Sets the global limit for the conversation memory window (128k tokens).
        OLLAMA_CONTEXT_LENGTH = "131072";

        # Compresses conversation memory to 4-bit, saving ~75% of RAM compared to uncompressed.
        OLLAMA_KV_CACHE_TYPE = "q4_0";

        # Prevents multiple models from loading simultaneously to avoid exhausting your 24GB RAM.
        OLLAMA_MAX_LOADED_MODELS = "1";

        # Immediately unloads the model from RAM when it is no longer being actively used.
        OLLAMA_NOPRELOAD = "1";

        # Disables internal "Chain of Thought" reasoning steps to save processing time and memory.
        OLLAMA_REASONING = "false";
      };
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/ollama.log";
        StandardErrorPath = "/tmp/ollama.err";
      };
    };
  };
}
