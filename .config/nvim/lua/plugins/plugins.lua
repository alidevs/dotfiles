-- plugins.lua for NvChad Neovim Configuration
local overrides = require "custom.configs.overrides"

local plugins = {
  -- Telescope and Extensions
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },

  -- Rust Support
  {
    "rust-lang/rust.vim",
    ft = { "rust" },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {}
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
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension "import"
    end,
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
      "nvim-tree/nvim-web-devicons", -- optional dependency
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
        "ruff",
        "mypy",
        "black",
        "isort",
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
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
    config = function()
      require("venv-selector").setup {
        -- Your options go here
        name = "python-3.12",
        auto_refresh = true,
      }
    end,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { "<leader>vs", "<cmd>VenvSelect<cr>" },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    },
  },
  -- AI
  {
    "github/copilot.vim",
    config = function()
      require "plugins.configs.copilot"
    end,
    lazy = false,
  },

  -- Overrides
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
}

return plugins
