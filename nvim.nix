{
  vim = {
    options = {
      tabstop = 2;
      shiftwidth = 2;
    };

    theme = {
      enable = true;
      style = "dark";
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
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      rust.enable = true;
      nix.enable = true;
      bash.enable = true;
    };

    terminal.toggleterm.enable = true;
    terminal.toggleterm.mappings.open = "<C-\\>";

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
        action = ":bd";
        desc = "Close buffer";
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
      vim-wakatime.enable = false;
      icon-picker.enable = true;
      surround.enable = true;
      diffview-nvim.enable = true;
      motion = {
        hop.enable = true;
        leap.enable = true;
        precognition.enable = false;
      };

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
    filetree.neo-tree.enable = true;
    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = false; # throws an annoying debug message
    };
  };
}
