{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.agents;
in {
  options.agents.enable = lib.mkEnableOption "LLM agents and tools";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # AI tools
      llm-agents.antigravity-cli
      whichllm

      # python
      python3
      uv
      ty
      ruff

      # Typescript
      nodejs
      biome
      typescript-language-server
      typescript

      # Utilities
      docker
    ];

    services.ollama.enable = true;

    programs.opencode = {
      enable = true;
      package = pkgs.llm-agents.opencode;
      settings = {
        provider = {
          ollama = {
            npm = "@ai-sdk/openai-compatible";
            name = "Ollama (local)";
            options.baseURL = "http://localhost:11434/v1";
            models = {
              "batiai/gemma4-26b:iq4" = {
                name = "Gemma4 26B IQ4 (local)";
                "body" = {
                  "think" = false;
                };
                "options" = {
                  "reasoningEffort" = "none";
                };
              };
              " Qwen/Qwen3-30B-A3B-GGUF" = {
                name = "Qwen3 Coder 30B A3B (local)";
                "body" = {
                  "think" = false;
                };
                "options" = {
                  "reasoningEffort" = "none";
                };
              };
            };
          };
        };
        model = "ollama/batiai/gemma4-26b:iq4";
      };
    };
  };
}
