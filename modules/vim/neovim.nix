{
  pkgs,
  inputs,
  user,
  ...
}: {
  home.packages = with pkgs; [
    # for telescope
    ripgrep
    fd

    # for nvim-sitter
    tree-sitter
  ];
  home.file.".config/lazygit/config.yml".text = ''
    git:
      paging:
        colorArg: always
        # useConfig: true
  ''; # TODO: set useConfig to true

  programs.zsh.shellAliases = {
    v = "nvim";
  };

  programs.nixvim = {
    enable = true;
    colorschemes.vscode.enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>Telescope file_browser<CR>";
      }
      {
        mode = "v";
        key = "<leader>h";
        action = "<cmd>Telescope grep_string<CR>";
      }
      {
        mode = "n";
        key = "gg";
        action = "<cmd>LazyGit<CR>";
      }
      {
        mode = "n";
        key = "<S-k>";
        action = "vim.lsp.buf.hover()";
      }
      {
        mode = "n";
        key = "<leader>g";
        action = "<cmd>Telescope live_grep_args<CR>";
      }
    ];

    diagnostic.settings = {
      virtual_lines = {
        current_line = true;
      };
      virtual_text = true;
      update_in_insert = true;
    };

    plugins = {
      web-devicons = {
        enable = true;
      };

      telescope = {
        enable = true;
        extensions.file-browser = {
          enable = true;
          settings = {
            hijack_netrw = true;
            grouped = true;
            depth = 1000;
          };
        };
        extensions.fzf-native.enable = true;
        extensions.live-grep-args.enable = true;
        extensions.live-grep-args.settings = {
          auto_quoting = false;
        };
      };

      nvim-tree = {
        enable = true;
        openOnSetup = true;
        openOnSetupFile = true;
        renderer.rootFolderLabel = false;
      };

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
        };
      };

      lazygit = {
        enable = true;
      };

      lsp.enable = true;
      lsp.servers = {
        nixd.enable = true;
        nixd.settings = {
          cmd = [pkgs.nixd];
          nixpkgs.expr = "import ${inputs.nixpkgs} { }";
          home_manager.expr = "(builtins.getFlake (''\"git+file://''\" + toString ./.)).packages.${pkgs.system}.homeConfigurations.${user}.options";
          formatting.command = null;
        };
        jdtls.enable = true;
        jdtls.settings = {
          on_attach = ''
            function(_, bufnr)
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = '[G]oto [D]efinition' })
              bemol()
            end
          '';
        };
      };

      # to enable format on save
      lsp-format.enable = true;

      indent-blankline.enable = true;
      lualine.enable = true;

      none-ls = {
        enable = true;
        sources.formatting.alejandra.enable = true;
        sources.formatting.shfmt.enable = true;
        sources.formatting.mdformat.enable = true;
        sources.formatting.stylua.enable = true;
      };
      treesitter-context.enable = true;
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = "all";
          ignore_install = [
            # TODO: remove line when ipkg installation works again
            "ipkg"
          ];
          highlight.enable = true;
          indent.enable = true;
        };
      };
    };
    extraPlugins = with pkgs.vimPlugins; [vim-be-good];
    extraConfigLua = ''
      function bemol()
        local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory'})[1]
        local ws_folders_lsp = {}
        if bemol_dir then
          local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
          if file then
            for line in file:lines() do
      	table.insert(ws_folders_lsp, line)
            end
            file:close()
          end
        end

        for _, line in ipairs(ws_folders_lsp) do
          vim.lsp.buf.add_workspace_folder(line)
        end
      end
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    JDTLS_JVM_ARGS = "-javaagent:${pkgs.lombok}/share/java/lombok.jar";
  };
}
