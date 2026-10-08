-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      if not opts.treesitter then return end
      -- Neovim 0.12 ships compatible parsers for these languages.
      local builtin_parsers = {
        c = true,
        lua = true,
        markdown = true,
        markdown_inline = true,
        query = true,
        vim = true,
        vimdoc = true,
      }
      opts.treesitter.auto_install = false
      opts.treesitter.ensure_installed = vim.tbl_filter(
        function(parser) return not builtin_parsers[parser] end,
        opts.treesitter.ensure_installed
      )
      opts.treesitter.ensure_installed =
        require("astrocore").list_insert_unique(opts.treesitter.ensure_installed, { "sql" })
    end,
  },
  -- astroui
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "astrodark",
      -- highlights = {
      --   astrodark = {
      --     Normal = { bg = "#000000" },
      --   },
      -- },
    },
  },
  -- astrocore
  {
    "AstroNvim/astrocore",
    opts = {
      -- vim options can be configured here
      options = {
        opt = { -- vim.opt.<key>
          wrapscan = true, -- search wrap around
          wrap = true,
          -- showtabline = 2,
        },
        g = { -- vim.g.<key>
          -- configure global vim variables (vim.g)
          -- lsp = {
          --   inlay_hints_enabled = false, -- disable inlay hints by default
          --   inlay_hints = false,
          -- },
        },
      },
      mappings = {
        n = {
          ["<Leader>A"] = { "ggVG<cr>", desc = "Select all" },
          ["<Leader><cr>"] = { "<cmd>nohl<cr>", desc = "No highlight" },
          ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
          ["<C-w>"] = { "<cmd>w!<cr>", desc = "Save" },
          ["<Leader>r"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" },
          ["L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          -- ["0"] = { "^" },
        },
        t = {
          ["<C-t>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "██╗   ██╗ ██████╗ ██╗      ██████╗ ",
            "╚██╗ ██╔╝██╔═══██╗██║     ██╔═══██╗",
            " ╚████╔╝ ██║   ██║██║     ██║   ██║",
            "  ╚██╔╝  ██║   ██║██║     ██║   ██║",
            "   ██║   ╚██████╔╝███████╗╚██████╔╝",
            "   ╚═╝    ╚═════╝ ╚══════╝ ╚═════╝ ",
          }, "\n"),
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
          { section = "startup" },
        },
      },
      terminal = {
        enabled = true,
      },
    },
  },
  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },
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
    keys = { { "<Leader>tw", "<cmd>Twilight<cr>", desc = "Twilight" } },
    opts = function() require("twilight").setup() end,
  },
  -- todo
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "folke/trouble.nvim", cmd = "Trouble", opts = {} },
    },
    keys = {
      { "<Leader>td", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
      { "<Leader>tf", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<Leader>tl", "<cmd>TodoLocList<cr>", desc = "Todo LocList" },
      { "<Leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Todo QuickFix" },
    },
  },
  -- hop
  {
    "smoka7/hop.nvim",
    event = "BufRead",
    keys = {
      { "<Leader>j", "<cmd>HopLine<cr>", desc = "Go to any line" },
      { "<Leader>w", "<cmd>HopWordCurrentLine<cr>", desc = "Go to any word current line" },
      { "<Leader>/", "<cmd>HopPattern<cr>", desc = "Search and go" },
      { "<Leader>q", "<cmd>HopWord<cr>", desc = "Go to any word in the current buffer" },
    },
    config = function() require("hop").setup() end,
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
  -- diffview
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose" },
    keys = {
      { "<Leader>go", "<cmd>DiffviewOpen main<cr>", desc = "DiffviewOpen branch (main)" },
      { "<Leader>gO", "<cmd>DiffviewOpen master<cr>", desc = "DiffviewOpen branch (master)" },
      { "<Leader>gq", "<cmd>DiffviewClose<cr>", desc = "DiffviewClose" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        numhl = true,
        current_line_blame = true,
      }
    end,
    keys = {
      { "<Leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous Git hunk" },
      { "<Leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Git hunk" },
      { "<Leader>gP", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Git hunk" },
      { "<Leader>gD", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle Git deleted" },
      { "<Leader>gW", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "Toggle Git word diff" },
      { "<Leader>gH", "<cmd>Gitsigns toggle_linehl<cr>", desc = "Toggle Git line highlight" },
      { "<Leader>gT", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle Git signs" },
      { "<Leader>gm", "<cmd>Gitsigns change_base main true<cr>", desc = "Change Git base (main)" },
      { "<Leader>ga", "<cmd>Gitsigns change_base master true<cr>", desc = "Change Git base (master)" },
      { "<Leader>gr", "<cmd>Gitsigns reset_base true<cr>", desc = "Reset Git base" },
    },
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
    keys = {
      { "ga", "<cmd>GoAlt<cr>", desc = "Go to alternative go file" },
    },
  },
  -- surround
  {
    "kylechui/nvim-surround",
    branch = "main",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },
  -- last place
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit",
          "gitrebase",
          "svn",
          "hgcommit",
        },
        lastplace_open_folds = true,
      }
    end,
  },
  -- python
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    opts = {
      -- Your options go here
      name = ".venv",
      -- auto_refresh = false
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      {
        "<leader>vc",
        function() require("venv-selector.cached_venv").retrieve() end,
        desc = "Restore cached virtual environment",
      },
    },
  },
  -- ansible
  -- {
  --   "pearofducks/ansible-vim",
  --   ft = { "yaml.ansible" },
  -- },
  -- astrolsp
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      -- Configuration table of features provided by AstroLSP
      features = {
        inlay_hints = false, -- enable/disable inlay hints on start
      },
      config = {
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
      },
    },
  },
  -- llm
  -- {
  --   "Kurama622/llm.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  --   cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  --   config = function()
  --     local tools = require "llm.common.tools"
  --     require("llm").setup {
  --       -- [[ ollama ]]
  --       url = "http://localhost:11434/api/chat",
  --       model = "qwen2.5-coder",
  --       api_type = "ollama",
  --       fetch_key = function()
  --         -- return vim.env.LOCAL_LLM_KEY
  --         return ""
  --       end,
  --       streaming_handler = local_llm_streaming_handler,
  --       app_handler = {
  --         WordTranslate = {
  --           handler = tools.flexi_handler,
  --           prompt = "Translate the following text to Chinese, please only return the translation",
  --           opts = {
  --             parse_handler = local_llm_parse_handler,
  --             exit_on_move = true,
  --             enter_flexible_window = false,
  --           },
  --         },
  --       },
  --     }
  --   end,
  --   keys = {
  --     { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
  --     -- { "<leader>ts", mode = "x", "<cmd>LLMAppHandler WordTranslate<cr>" },
  --     -- { "<leader>ae", mode = "v", "<cmd>LLMAppHandler CodeExplain<cr>" },
  --     { "<leader>at", mode = "n", "<cmd>LLMAppHandler Translate<cr>" },
  --     { "<leader>tc", mode = "x", "<cmd>LLMAppHandler TestCode<cr>" },
  --     -- { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>" },
  --     { "<leader>au", mode = "n", "<cmd>LLMAppHandler UserInfo<cr>" },
  --     { "<leader>ag", mode = "n", "<cmd>LLMAppHandler CommitMsg<cr>" },
  --     { "<leader>ad", mode = "v", "<cmd>LLMAppHandler DocString<cr>" },
  --     { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>" },
  --     { "<leader>ae", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>" },
  --     { "<leader>ts", mode = "x", "<cmd>LLMSelectedTextHandler 英译汉<cr>" },
  --   },
  -- },
  -- opencode
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(picker)
                local selections = vim.tbl_map(
                  function(selection)
                    return selection.file
                        and require("opencode").format {
                          path = selection.file,
                          from = selection.pos,
                          to = selection.end_pos,
                        }
                      or selection.text
                  end,
                  picker:selected { fallback = true }
                )
                require("opencode").prompt(table.concat(selections, ", ") .. " ")
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      local opencode_cmd = "opencode --port"
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = "bottom",
          enter = false,
        },
      }
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function() require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts) end,
        },
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set(
        { "n", "x" },
        "<C-a>",
        function() require("opencode").ask "@this: " end,
        { desc = "Ask opencode…" }
      )
      vim.keymap.set(
        { "n", "x" },
        "<C-x>",
        function() require("opencode").select() end,
        { desc = "Execute opencode action…" }
      )
      vim.keymap.set(
        { "n", "t" },
        "<C-;>",
        function() require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts) end,
        { desc = "Toggle opencode" }
      )

      vim.keymap.set(
        { "n", "x" },
        "go",
        function() return require("opencode").operator "@this " end,
        { desc = "Add range to opencode", expr = true }
      )
      vim.keymap.set(
        "n",
        "goo",
        function() return require("opencode").operator "@this " .. "_" end,
        { desc = "Add line to opencode", expr = true }
      )

      vim.keymap.set(
        "n",
        "<S-C-u>",
        function() require("opencode").command "session.half.page.up" end,
        { desc = "Scroll opencode up" }
      )
      vim.keymap.set(
        "n",
        "<S-C-d>",
        function() require("opencode").command "session.half.page.down" end,
        { desc = "Scroll opencode down" }
      )

      -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  },
  -- others
}
