{ inputs, ... }:
{
  imports = [
    inputs.nvf.nixosModules.default
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      options.tabstop = 4;

      theme.enable = true;
      theme.name = "gruvbox";
      theme.style = "dark";
      theme.transparent = true;

      lsp.enable = true;
      lsp.formatOnSave = true;

      languages = {
        enableLSP = true;
        rust.enable = true;
        rust.crates.enable = true;
        nix.enable = true;
        bash.enable = true;
      };

      terminal.toggleterm.enable = true;
      terminal.toggleterm.mappings.open = "<C-\\>";

      keymaps = [
        {
          key = "<C-\\>";
          mode = ["t"];
          silent = true;
          action = "<C-\\><C-n><C-w>k";
        }
      ];

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      autopairs.nvim-autopairs.enable = true;
      treesitter.context.enable = true;
      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };
    };
  };
}
