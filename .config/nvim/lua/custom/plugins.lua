local plugins = {
  {
    "tzachar/local-highlight.nvim",
    event = "VeryLazy",
    config = function ()
      require("local-highlight").setup {
        file_types = {
          "python",
          "lua",
          "json",
          "yaml",
          "toml",
          "html"
        },

        hlgroup = "Visual"
      }
    end,
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require('leap').add_default_mappings()
    end,
  },
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
        "isort",
        "flake8"
      },
    },
  },
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
