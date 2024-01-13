local plugins = {
  {
    "SmiteshP/nvim-navic",
    config = function ()
      require "custom.configs.nvim-navic"
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here, or leave empty table for default options
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    }
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
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function ()
  --     require "custom.configs.refactoring"
  --   end,
  --   lazy = false
  -- },
  {
    "tpope/vim-surround",
    lazy = false
  },
  {
    "2nthony/vitesse.nvim",
    dependencies = {
      "tjdevries/colorbuddy.nvim"
    },
    config = function ()
      require("vitesse").setup {
        transparent_background = false,
      }
    end
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
