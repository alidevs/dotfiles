-- plugins.lua for NvChad Neovim Configuration
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
      require("lua/config/treesitter-context").setup()
    end,
  },

  -- Search and Replace
  {
    "nvim-pack/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },

  -- UI Enhancements
  {
    "echasnovski/mini.nvim",
    event = "BufEnter",
    config = function()
      require("custom.configs.mini").setup()
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("custom.configs.noice").setup()
    end,
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  },

  -- Language and Syntax Support
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("custom.configs.mason").setup()
    end,
  },

  -- Additional Plugins
  {
    "github/copilot.vim",
    config = function()
      require "custom.configs.copilot"
    end,
    lazy = false,
  },
}

return plugins
