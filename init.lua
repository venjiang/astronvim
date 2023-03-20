return {
  -- options
  options = {
    g = {
      mapleader = ",", -- sets vim.g.mapleader
    },
  },
  -- mappings
  mappings = {},
  -- lsp
  lsp = {},
  -- plugins
  plugins = {
    {
      "nvim-neo-tree/neo-tree.nvim",
      config = {
        window = {
          position = "right",
        },
      },
    },
    -- others
  },
}
