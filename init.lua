return {
  opt = {
    timeoutlen = 100, -- Shorten key timeout length a little bit for which-key
    timeout = 300,
  },
  options = {
    g = {
      mapleader = ",", -- sets vim.g.mapleader
    },
  },
  -- mappings
  mappings = {
    n = {
      ["<leader>a"] = { "ggVG<cr>", desc = "Select all" },
      ["<leader><cr>"] = { "<cmd>:nohl<cr>", desc = "No highlight" },
      ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      ["<C-w>"] = { "<cmd>w!<cr>", desc = "Save" },
      ["<leader>r"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" },
      ["L"] = {
        function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        desc = "Next buffer",
      },
      ["H"] = {
        function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        desc = "Previous buffer",
      },
    },
    t = {
      ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
  },
  -- lsp
  lsp = {},
  -- plugins
  plugins = {
    {
      "goolord/alpha-nvim",
      opts = function(_, opts)      -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
          "",
          "",
        }
        -- opts.section.buttons.val = {}
      end,
    },
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
