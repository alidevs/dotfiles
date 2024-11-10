local overrides = require "custom.configs.overrides"

local plugins = {
  -- LSP and Language Support
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "yamlls",
        "biome",
        "yamlfix",
        "basedpyright",
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
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    opts = function()
      return require "plugins.configs.null-ls"
    end,
  },
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
    enabled = false,
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_signature").setup()
    end,
  },

  -- Treesitter and Syntax
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
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("plugins.configs.nvim-treesitter-textobjects").setup()
    end,
    lazy = false,
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
    {
      "Bekaboo/dropbar.nvim",
      event = "BufEnter",
      dependencies = {
        "nvim-telescope/telescope-fzf-native.nvim",
      },
    },
  },
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
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          file_ignore_patterns = { ".git/", "node_modules/", "venv/", ".venv/", ".direnv/", ".mypy_cache/" },
          vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--fixed-strings",
          },
        },
      })
    end,
  },

  -- Diagnostics and Troubleshooting
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    event = "BufReadPost",
    keys = {
      {
        "<leader>dd",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>dX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>dS",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>dL",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },

  -- AI and Code Assistance
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

  -- Utility and Productivity
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup()
    end,
  },
  {
    "aserowy/tmux.nvim",
    config = function()
      return require("tmux").setup()
    end,
    event = "VeryLazy",
  },
  {
    "nvim-pack/nvim-spectre",
    event = "BufRead",
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
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
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
    "wakatime/vim-wakatime",
    lazy = false,
  },
}

return plugins
