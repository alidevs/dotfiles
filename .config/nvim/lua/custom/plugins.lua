local plugins = {
  {
    "esensar/nvim-dev-container",
    config = function ()
      require("devcontainer").setup()
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function ()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "mypy",
        "ruff",
        "black",
      },
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
      require "custom.configs.refactoring"
    end,
    lazy = false
  },
  {
    "tpope/vim-surround",
    lazy = false
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
  {
    "2nthony/vitesse.nvim",
    dependencies = {
      "tjdevries/colorbuddy.nvim"
    }
  },
  {
    "github/copilot.vim",
    config = function ()
      require "custom.configs.copilot"
    end,
    lazy = false
  }
}

return plugins
