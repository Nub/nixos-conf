{
  pkgs,
  inputs,
  ...
}: {
  vim = {
    options = {
      tabstop = 2;
      shiftwidth = 2;
    };

    startPlugins = [
      "rustaceanvim"
    ];

    extraPlugins = {
      claudecode = {
        package = pkgs.vimUtils.buildVimPlugin {
          pname = "claudecode-nvim";
          version = "main";
          src = inputs.claudecode-nvim;
        };
        setup = "require('claudecode').setup {}";
      };
    };

    theme = {
      enable = true;
      # style = "dark";
      transparent = true;
      name = "nord";
      # name = "base16";
      # base16-colors = {
      #   inherit (config.lib.stylix.colors) base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F;
      # };
    };

    ui = {
      borders.enable = true;
      noice.enable = true;
      colorizer.enable = true;
      illuminate.enable = true;
      breadcrumbs = {
        enable = false;
        navbuddy.enable = false;
      };
      smartcolumn = {
        enable = false;
      };
      fastaction.enable = true;
    };

    spellcheck.enable = false;

    lsp = {
      enable = true;
      formatOnSave = true;
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      rust.enable = true;
      nix.enable = true;
      bash.enable = true;
      wgsl.enable = true;
    };

    terminal = {
      toggleterm = {
        enable = true;
        mappings.open = "<C-\\>";
        setupOpts.winbar.enabled = false;
      };
    };

    keymaps = [
      {
        key = "<C-\\>";
        mode = ["t"];
        action = "<cmd>ToggleTerm close<cr>";
        desc = "Close toggle term";
      }
      {
        key = "<leader>e";
        mode = ["n"];
        action = "<cmd>Neotree toggle<cr>";
        desc = "File browser toggle";
      }
      {
        key = "<leader>c";
        mode = ["n"];
        action = "<cmd>bd<cr>";
        desc = "Close buffer";
      }
      {
        key = "<leader>d";
        mode = ["n"];
        action = "<cmd>Telescope diagnostics<cr>";
        desc = "Search diagnostics";
      }
      {
        key = "<leader>i";
        mode = ["n"];
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        desc = "Pull up docs";
      }
      {
        key = "<leader>ff";
        mode = ["n"];
        action = "<cmd>Telescope find_files<cr>";
        desc = "Search files by name";
      }
      {
        key = "<leader>ft";
        mode = ["n"];
        action = "<cmd>Telescope live_grep<cr>";
        desc = "Search files by contents";
      }
      {
        key = "<leader>fr";
        mode = ["n"];
        action = "<cmd>Telescope lsp_references<cr>";
        desc = "Search references";
      }
      {
        key = "<leader>fs";
        mode = ["n"];
        action = "<cmd>Telescope lsp_document_symbols<cr>";
        desc = "Search symbols";
      }
      {
        key = "<C-h>";
        mode = ["i"];
        action = "<Left>";
        desc = "Move left in insert mode";
      }
      {
        key = "<C-j>";
        mode = ["i"];
        action = "<Down>";
        desc = "Move down in insert mode";
      }
      {
        key = "<C-k>";
        mode = ["i"];
        action = "<Up>";
        desc = "Move up in insert mode";
      }
      {
        key = "<C-l>";
        mode = ["i"];
        action = "<Right>";
        desc = "Move right in insert mode";
      }
      {
        key = "<leader>nh";
        mode = ["n"];
        action = ":nohl<CR>";
        desc = "Clear search highlights";
      }
      {
        key = "<leader>ac";
        mode = ["n"];
        action = "<cmd>ClaudeCode<cr>";
        desc = "Toggle Claude Code";
      }
      {
        key = "<leader>as";
        mode = ["n"];
        action = "<cmd>ClaudeCodeSend<cr>";
        desc = "Send to Claude Code";
      }
      {
        key = "<leader>as";
        mode = ["v"];
        action = "<cmd>ClaudeCodeSend<cr>";
        desc = "Send selection to Claude Code";
      }
    ];

    comments = {
      comment-nvim = {
        enable = true;
        mappings.toggleSelectedLine = "<Space><Space>";
        mappings.toggleCurrentLine = "<Space><Space>";
      };
    };

    notify = {
      nvim-notify.enable = true;
    };

    utility = {
      ccc.enable = false;
      surround.enable = true;
      diffview-nvim.enable = true;
      images = {
        image-nvim.enable = false;
      };
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        close_if_last_window = true;
      };
    };

    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
    };
  };
}
