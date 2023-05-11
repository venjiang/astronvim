return {
  opt = {
    timeoutlen = 100, -- Shorten key timeout length a little bit for which-key
    timeout = 300,
  },
  options = {
    opt = {
      foldcolumn = "0", -- hide foldcolumn
    },
    g = {
      mapleader = ",", -- sets vim.g.mapleader
      -- copilot
      copilot_no_tab_map = true,
      copilot_assume_mapped = true,
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
      -- hop
      ["<leader>j"] = { "<cmd>HopLine<cr>", desc = "Go to any line" },
      ["<leader>w"] = { "<cmd>HopWordCurrentLine<cr>", desc = "Go to any word current line" },
      ["<leader>/"] = { "<cmd>HopPattern<cr>", desc = "Search and go" },
      ["<leader>q"] = { "<cmd>HopWord<cr>", desc = "Go to any word in the current buffer" },
    },
    t = {
      ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    i = {
      ["<c-l>"] = { 'copilot#Accept("<CR>")', silent = true, expr = true, replace_keycodes = false },
      ["<c-j>"] = { "copilot#Next()", silent = true, expr = true },
      ["<c-k>"] = { "copilot#Previous()", silent = true, expr = true },
    },
  },
  -- lsp
  lsp = {},
  -- plugins
  plugins = {
    -- dashboard
    {
      "goolord/alpha-nvim",
      opts = function(_, opts) -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
          "",
          "",
        }
        -- opts.section.buttons.val = {}
      end,
    },
    -- tree
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        window = {
          position = "right",
        },
      },
    },
    -- twilight
    {
      "folke/twilight.nvim",
      opts = function() require("twilight").setup {} end,
    },

    -- hop
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      opts = function() require("hop").setup() end,
    },
    -- copilot
    {
      "github/copilot.vim",
      event = "InsertEnter",
    },
    -- git
    {
      "tpope/vim-fugitive",
      cmd = {
        "G",
        "Git",
        "Gdiffsplit",
        "Gread",
        "Gwrite",
        "Ggrep",
        "GMove",
        "GDelete",
        "GBrowse",
        "GRemove",
        "GRename",
        "Glgrep",
        "Gedit",
      },
      ft = { "fugitive" },
    },

    -- others
  },
}
