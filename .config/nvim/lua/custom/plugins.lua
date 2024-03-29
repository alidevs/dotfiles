local plugins = {
  {
    "Acksld/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup {
        history = 1000,
        enable_persistent_history = false,
        length_limit = 1048576,
        continuous_sync = false,
        db_path = vim.fn.stdpath "data" .. "/databases/neoclip.sqlite3",
        filter = nil,
        preview = true,
        prompt = nil,
        default_register = '"',
        default_register_macros = "q",
        enable_macro_history = true,
        content_spec_column = false,
        disable_keycodes_parsing = false,
        on_select = {
          move_to_front = false,
          close_telescope = true,
          paste = true,
        },
        on_paste = {
          set_reg = false,
          move_to_front = false,
          close_telescope = true,
        },
        on_replay = {
          set_reg = false,
          move_to_front = false,
          close_telescope = true,
        },
        on_custom_action = {
          close_telescope = true,
        },
        keys = {
          telescope = {
            i = {
              select = "<cr>",
              paste = "<c-p>",
              paste_behind = "<c-k>",
              replay = "<c-q>", -- replay a macro
              delete = "<c-d>", -- delete an entry
              edit = "<c-e>",   -- edit an entry
              custom = {},
            },
            n = {
              select = "<cr>",
              paste = "p",
              --- It is possible to map to more than one key.
              -- paste = { 'p', '<c-p>' },
              paste_behind = "P",
              replay = "q",
              delete = "d",
              edit = "e",
              custom = {},
            },
          },
          fzf = {
            select = "default",
            paste = "ctrl-p",
            paste_behind = "ctrl-k",
            custom = {},
          },
        },
      }
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "BufRead",
    config = function()
      require "custom.configs.ufo"
    end,
    dependencies = {
      {
        "kevinhwang91/promise-async",
      },
    },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },
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
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    config = function()
      require("treesitter-context").setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "inner",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "topline",         -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup {}

      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table {
                results = file_paths,
              },
              sorter = conf.generic_sorter {},
              previewer = conf.file_previewer {},
            })
            :find()
      end

      vim.keymap.set("n", "<leader>e", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })
      vim.keymap.set("n", "<leader>m", function()
        harpoon:list():append()
      end, { desc = "Add current file to harpoon" })
      vim.keymap.set("n", "<leader>md", function()
        harpoon:list():remove()
      end, { desc = "Delete current file from harpoon" })
      vim.keymap.set("n", "<leader>]", function()
        harpoon:list():next()
      end, { desc = "Navigate to next file in harpoon" })
      vim.keymap.set("n", "<leader>[", function()
        harpoon:list():prev()
      end, { desc = "Navigate to previous file in harpoon" })
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
  },
  {
    "echasnovski/mini.nvim",
    enabled = true,
    event = "BufEnter",
    config = function()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.move").setup()
      require("mini.indentscope").setup {
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
              "lazyterm",
            },
            callback = function()
              vim.b.miniindentscope_disable = true
            end,
          })
        end,
      }
    end,
  },
  {
    "tzachar/local-highlight.nvim",
    event = "VeryLazy",
    config = function()
      require("local-highlight").setup {
        file_types = {
          "python",
          "lua",
          "json",
          "yaml",
          "toml",
          "html",
        },
        hlgroup = "Visual",
      }
    end,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
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
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
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
          bottom_search = true,         -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
      }

      require("notify").setup {
        background_colour = "#000000",
      }
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.none-ls"
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
    opts = {
      ensure_installed = {
        "pyright",
        "mypy",
        -- "ruff",
        "rust-analyzer",
        "black",
        "isort",
        "flake8",
      },
    },
  },
  {
    "2nthony/vitesse.nvim",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
    },
    config = function()
      require("vitesse").setup {
        transparent_background = false,
      }
    end,
  },
  {
    "github/copilot.vim",
    config = function()
      require "custom.configs.copilot"
    end,
    lazy = false,
  },
}

return plugins
