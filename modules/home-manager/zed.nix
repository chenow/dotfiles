{
  lib,
  config,
  ...
}: {
  options.zed.enable = lib.mkEnableOption "Zed editor";

  config = lib.mkIf config.zed.enable {
    programs.zsh.shellAliases.z = "zeditor";

    programs.zed-editor = {
      enable = true;

      extensions = [
        "nix"
        "python-lsp"
        "ruff"
        "biome"
        "html"
        "toml"
        "dockerfile"
        "docker-compose"
        "make"
        "tailwind-color-hint"
        "csv"
        "rainbow-csv"
        "env"
        "git-firefly"
        "mermaid"
        "vscode-dark-modern"
        "context7-mcp-server"
      ];

      userSettings = {
        language_models.ollama = {
          api_url = "http://localhost:11434";
          available_models = [
            {
              name = "batiai/qwen3.5-9b";
              display_name = "Qwen 3.6 5.6GB";
              max_tokens = 131072;
              supports_tools = true;
              supports_images = false;
              options.think = false;
            }
            {
              name = "batiai/gemma4-e4b:q4";
              display_name = "Gemma4 2B";
              max_tokens = 131072;
              supports_tools = true;
              supports_images = false;
              options.think = false;
            }
          ];
        };

        # Inline Autocomplete (Edit Predictions)
        edit_predictions.mode = "eager";
        edit_predictions.default_model = {
          provider = "ollama";
          model = "qwen2.5-coder:0.5b";
        };

        # Agent Servers / ACP
        agent_servers = {
          kiro = {
            type = "custom";
            command = "kiro-cli";
            args = ["acp"];
            env = {};
          };
        };

        # --- Editor UI & Theme ---
        vim_mode = false;
        theme = {
          mode = "dark";
          dark = "VS Code Dark Modern";
          light = "VS Code Light Modern";
        };
        ui_font_size = 16;
        buffer_font_size = 14;
        buffer_font_family = "JetBrainsMono Nerd Font";
        format_on_save = "on";

        # Performance Settings
        minimap.enabled = false;
        inlay_hints.enabled = true;
        inline_diagnostics.enabled = true;
        linked_edits = true;

        # Languages (LSP/Formatters)
        languages = {
          Nix = {
            formatter.external = {
              command = "alejandra";
              arguments = [];
            };
          };
          Python = {
            formatter.external = {
              command = "ruff";
              arguments = ["format" "-"];
            };
            code_actions_on_format = {
              "source.fixAll.ruff" = true;
              "source.organizeImports.ruff" = true;
            };
          };
        };
      };
    };
  };
}
