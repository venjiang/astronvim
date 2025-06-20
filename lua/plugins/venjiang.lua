-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
-- local function local_llm_streaming_handler(chunk, line, assistant_output, bufnr, winid, F)
--   if not chunk then return assistant_output end
--   local tail = chunk:sub(-1, -1)
--   if tail:sub(1, 1) ~= "}" then
--     line = line .. chunk
--   else
--     line = line .. chunk
--     local status, data = pcall(vim.fn.json_decode, line)
--     if not status or not data.message.content then return assistant_output end
--     assistant_output = assistant_output .. data.message.content
--     F.WriteContent(bufnr, winid, data.message.content)
--     line = ""
--   end
--   return assistant_output
-- end
--
-- local function local_llm_parse_handler(chunk)
--   local assistant_output = chunk.message.content
--   return assistant_output
-- end

return {
  -- astrocore
  {
    "AstroNvim/astrocore",
    opts = {
      -- vim options can be configured here
      options = {
        opt = { -- vim.opt.<key>
          wrapscan = true, -- search wrap around
          wrap = true,
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
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<Leader>td", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
      { "<Leader>tf", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<Leader>tl", "<cmd>TodoLocList<cr>", desc = "Todo LocList" },
      { "<Leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Todo QuickFix" },
    },
  },
  -- hop
  {
    "phaazon/hop.nvim",
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
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
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
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
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
  -- copilot
  -- {
  --   "github/copilot.vim",
  --   event = "InsertEnter",
  --   init = function()
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --   end,
  --   keys = {
  --     { "<C-l>", 'copilot#Accept("<CR>")', mode = "i", silent = true, expr = true, replace_keycodes = false },
  --     { "<C-j>", "copilot#Next()", mode = "i", silent = true, expr = true },
  --     { "<C-k>", "copilot#Previous()", mode = "i", silent = true, expr = true },
  --   },
  -- },
  -- astrocommunity.completion.copilot-lua-cmp
  -- {
  --   "zbirenbaum/copilot.lua",
  --   -- cmd = "Copilot",
  --   -- event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup {
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         hide_during_completion = true,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<C-y>",
  --           accept_word = "<C-o>",
  --           accept_line = "<C-l>",
  --           next = "<C-j>",
  --           prev = "<C-k>",
  --           dismiss = "<C-u>",
  --         },
  --       },
  --     }
  --   end,
  -- },
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
  {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      -- add any opts here
      -- openai
      -- provider = "openai",
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- timeout in milliseconds
      --   temperature = 0, -- adjust if needed
      --   max_tokens = 4096,
      --   -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      -- },
      provider = "copilot",
      providers = {
        -- deepseek
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          -- model = "deepseek-coder",
          -- model = "deepseek-reasoner",
          model = "deepseek-chat",
        },
        -- ollama
        ollama = {
          __inherited_from = "openai",
          api_key_name = "",
          endpoint = "http://localhost:11434/v1",
          model = "qwen2.5-coder",
        },
        -- qwen
        ["aliyun-qwen"] = {
          __inherited_from = "openai",
          api_key_name = "QWEN_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "qwen-turbo",
        },
        ["aliyun-qwen-coder"] = {
          __inherited_from = "openai",
          api_key_name = "QWEN_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "qwen-coder-turbo",
        },
        ["aliyun-deepseek-v3"] = {
          __inherited_from = "openai",
          api_key_name = "QWEN_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "deepseek-v3",
        },
        ["aliyun-deepseek-r1"] = {
          __inherited_from = "openai",
          api_key_name = "QWEN_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "deepseek-r1",
        },
        -- vivgrid
        vivgrid = {
          __inherited_from = "openai",
          api_key_name = "VIVGRID_API_KEY",
          endpoint = "https://api.vivgrid.com/v1",
          model = "gpt-4o",
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- others
}
