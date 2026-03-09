{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.llm-agents;
  ollama-completions = pkgs.fetchFromGitHub {
    owner = "ocodo";
    repo = "ollama_zsh_completion";
    rev = "ff683469b770c59f9b150878baf7846540fefd9c";
    hash = "sha256-TaNBTREO/YrvQ2v6Yf/EP8nR40zr1M4BT1cCTPaGuJE=";
  };
in {
  options.llm-agents.enable = lib.mkEnableOption "LLM agents and tools";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.ollama
      pkgs.llm-agents.claude-code
      pkgs.llm-agents.gemini-cli
      pkgs.llm-agents.opencode
    ];

    xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      model = "ollama/glm-4.7-flash";
      mcp.context7 = {
        type = "remote";
        url = "https://mcp.context7.com/mcp";
      };
      provider.ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama (local)";
        options.baseURL = "http://localhost:11434/v1";
        # Benchmarks on M4 Pro 24GB (gen tok/s | prompt tok/s):
        #   qwen2.5-coder:0.5b  — 232 | 77   (edit predictions only)
        #   qwen2.5-coder:7b    —  43 | 299
        #   glm-4.7-flash       —  38 | 52    (19GB, 93% GPU, best coding MoE)
        #   devstral             —  13 | 108
        #   qwen3-coder:30b     —  12 | 108*  (*swaps at 19GB, needs full RAM)
        models = {
          "glm-4.7-flash" = {
            name = "GLM-4.7 Flash 30B MoE (128K) — 38 tok/s";
            limit = {
              context = 131072;
              output = 16384;
            };
          };
          "qwen2.5-coder:7b" = {
            name = "Qwen 2.5 Coder 7B (32K) — 43 tok/s";
            limit = {
              context = 32768;
              output = 8192;
            };
          };
          "devstral" = {
            name = "Devstral 24B (128K) — 13 tok/s";
            limit = {
              context = 128000;
              output = 16384;
            };
          };
        };
      };
    };

    home.file.".zsh_completions/_ollama".source = "${ollama-completions}/_ollama";
    programs.zsh.initExtra = ''fpath=($HOME/.zsh_completions $fpath)'';

    programs.zsh.shellAliases = {
      oc = "opencode";
      cc = "claude";
    };
  };
}
