return {
  opt = {
    timeoutlen = 100, -- Shorten key timeout length a little bit for which-key
    timeout = 300,
    wrapscan = true,  -- search wrap around
  },
  options = {
    opt = {
      foldcolumn = "0", -- hide foldcolumn
    },
    g = {
      mapleader = ",", -- sets vim.g.mapleader
      -- copilot
      -- copilot_no_tab_map = true,
      -- copilot_assume_mapped = true,
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
    i = {},
  },
  -- lsp
  lsp = {
    -- formatting = {
    --   format_on_save = false, -- enable or disable automatic formatting on save
    -- },
  },
  -- plugins
  plugins = {
    -- dashboard
    {
      "goolord/alpha-nvim",
      opts = function(_, opts)      -- override the options using lazy.nvim
        opts.section.header.val = { -- change the header section value
          "██╗   ██╗ ██████╗ ██╗      ██████╗ ",
          "╚██╗ ██╔╝██╔═══██╗██║     ██╔═══██╗",
          " ╚████╔╝ ██║   ██║██║     ██║   ██║",
          "  ╚██╔╝  ██║   ██║██║     ██║   ██║",
          "   ██║   ╚██████╔╝███████╗╚██████╔╝",
          "   ╚═╝    ╚═════╝ ╚══════╝ ╚═════╝ ",
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
      cmd = { "Twilight", "TwilightEnable" },
      keys = { { "<leader>tw", "<cmd>Twilight<cr>", desc = "Twilight" } },
      opts = function() require("twilight").setup() end,
    },
    -- todo
    {
      "folke/todo-comments.nvim",
      event = "BufRead",
      dependencies = "nvim-lua/plenary.nvim",
      opts = function()
        require("todo-comments").setup()
        local uitls = require "astronvim.utils" --  astronvim utils
        uitls.set_mappings {
          n = {
            ["<leader>td"] = { "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
            ["<leader>tf"] = { "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
            ["<leader>tl"] = { "<cmd>TodoLocList<cr>", desc = "Todo LocList" },
            ["<leader>tq"] = { "<cmd>TodoQuickFix<cr>", desc = "Todo QuickFix" },
          },
        }
      end,
    },
    -- hop
    {
      "phaazon/hop.nvim",
      event = "BufRead",
      opts = function()
        require("hop").setup()
        local utils = require "astronvim.utils" --  astronvim utils
        utils.set_mappings {
          n = {
            ["<leader>j"] = { "<cmd>HopLine<cr>", desc = "Go to any line" },
            ["<leader>w"] = { "<cmd>HopWordCurrentLine<cr>", desc = "Go to any word current line" },
            ["<leader>/"] = { "<cmd>HopPattern<cr>", desc = "Search and go" },
            ["<leader>q"] = { "<cmd>HopWord<cr>", desc = "Go to any word in the current buffer" },
          },
        }
      end,
    },
    -- copilot
    {
      "github/copilot.vim",
      event = "InsertEnter",
      init = function()
        vim.g.copilot_no_tab_map = true
        vim.g.copilot_assume_mapped = true
        local utils = require "astronvim.utils" --  astronvim utils
        utils.set_mappings {
          i = {
            ["<c-l>"] = { 'copilot#Accept("<CR>")', silent = true, expr = true, replace_keycodes = false },
            ["<c-j>"] = { "copilot#Next()", silent = true, expr = true },
            ["<c-k>"] = { "copilot#Previous()", silent = true, expr = true },
          },
        }
      end,
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
    -- go
    {
      "ray-x/go.nvim",
      dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      opts = function() require("go").setup() end,
      event = { "CmdlineEnter" },
      ft = { "go", "gomod" },
      build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    -- others
  },
}
