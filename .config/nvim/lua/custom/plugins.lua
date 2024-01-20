local plugins = {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    event = "BufEnter",
    config = function ()
      require("mini.surround").setup()
      require("mini.move").setup()
      require("mini.indentscope").setup({
        event = { "BufReadPre", "BufNewFile" },
        opts = {
          symbol = "▏",
          options = { try_as_border = true },
        },
        init = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = {
              "help",
              "alpha",
              "dashboard",
              "neo-tree",
              "Trouble",
              "lazy",
              "mason",
              "notify",
              "toggleterm",
              "lazyterm"
            },
            callback = function()
              vim.b.miniindentscope_disable = true
            end
          })
        end
      })
    end
  },
  -- {
  --   "Bekaboo/dropbar.nvim",
  --   event = { "BufRead", "BufWinEnter", "BufNewFile" },
  --   config = function()
  --     require("dropbar").setup {
  --       sources = {
  --         path = {
  --           modified = function(sym)
  --             return sym:merge {
  --               name = sym.name .. "[+]",
  --               icon = " ",
  --               name_hl = "DiffAdded",
  --               icon_hl = "DiffAdded",
  --             }
  --           end,
  --         },
  --       },
  --     }
  --   end,
  -- },
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
  -- {
  --   "ggandor/leap.nvim",
  --   lazy = false,
  --   config = function()
  --     require('leap').add_default_mappings()
  --   end,
  -- },
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
    },
    config = function ()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })

      require("notify").setup({
        background_colour = "#000000",
      })
    end
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
