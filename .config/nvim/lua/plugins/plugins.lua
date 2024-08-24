local overrides = require "custom.configs.overrides"

local plugins = {
  -- Rust Support
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {},
      },
    },
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        inlay_hints = {
          highlight = "NonText",
        },
        server = {
          on_attach = function(client, bufnr)
            require("nvchad.configs.lspconfig").on_attach(client, bufnr)
            require("lsp-inlayhints").on_attach(client, bufnr)
          end,
        },
      }
    end,
  },

  -- Treesitter Enhancements
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("plugins.configs.nvim-treesitter-context").setup()
    end,
    lazy = false,
  },
  {
    "rrethy/vim-illuminate",
    lazy = false,
  },

  -- Search and Replace
  {
    "nvim-pack/nvim-spectre",
    event = "BufRead",
  },

  -- UI Enhancements
  {
    "echasnovski/mini.nvim",
    event = "BufEnter",
    config = function()
      require("plugins.configs.mini").setup()
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.noice").setup()
    end,
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  },
  {
    "utilyre/barbecue.nvim",
    lazy = false,
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  -- Language and Syntax Support
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    opts = function()
      return require "plugins.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "plugins.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "yamlfix",
        "pyright",
        "ruff",
        "mypy",
        "flake8",
        "rust-analyzer",
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    config = function()
      require("venv-selector").setup {
        name = "python-3.12",
        auto_refresh = true,
      }
    end,
    event = "VeryLazy",
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
  {
    "chrisbra/csv.vim",
    ft = { "csv" },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- AI
  {
    "github/copilot.vim",
    config = function()
      require "plugins.configs.copilot"
    end,
    lazy = true,
  },
  {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_word = "<A-Right>",
        },
      }
    end,
  },

  -- Overrides
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Quality of Life
  {
    "folke/zen-mode.nvim",
    lazy = false,
    opts = {
      window = {
        backdrop = 1.0,
        width = 140,
      },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      restricted_keys = {
        ["j"] = {},
        ["k"] = {},
        ["l"] = {},
        ["h"] = {},
      },
    },
    lazy = false,
    setup = function()
      require("hardtime").setup()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "rktjmp/paperplanes.nvim",
    event = "BufRead",
    setup = function()
      return require("plugins.configs.paperplanes").setup()
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
    event = "BufRead",
    opts = {
      duration = 500,
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
  {
    "oysandvik94/curl.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("curl").setup {}
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = require "plugins.configs.flash-keys",
  },
}

return plugins
