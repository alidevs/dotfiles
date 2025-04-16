local util = require("conform.util")
return {
  "stevearc/conform.nvim",
  opts = function()
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,           -- not recommended to change
        quiet = false,           -- not recommended to change
        lsp_format = "fallback", -- not recommended to change
      },
      formatters_by_ft = {
        php = { "pint" },
        blade = { "blade-formatter", "rustywind" },
        yaml = { "yamlfix" },
        python = {
          "ruff_fix",
          "ruff_format",
          "ruff_organize_imports"
        },
        json = { "biome" },
        -- typescriptreact = { "biome" },
        -- typescript = { "biome" },
        -- javascript = { "biome" },
        -- javascriptreact = { "biome" },
        go = { "gofmt" },
      },
      -- LazyVim will merge the options you set here with builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = { options = { ignore_errors = true } },
        pint = {
          meta = {
            url = "https://github.com/laravel/pint",
            description =
            "Laravel Pint is an opinionated PHP code style fixer for minimalists. Pint is built on top of PHP-CS-Fixer and makes it simple to ensure that your code style stays clean and consistent.",
          },
          command = util.find_executable({
            vim.fn.stdpath("data") .. "/mason/bin/pint",
            "vendor/bin/pint",
          }, "pint"),
          args = { "$FILENAME" },
          stdin = false,
        },
        yamlfix = function()
          return {
            env = {
              YAMLFIX_SEQUENCE_STYLE = "block_style",
              YAMLFIX_WHITELINES = "1",
              YAMLFIX_quote_representation = "\"",
              YAMLFIX_SECTION_WHITELINES = "2",
            },
          }
        end,
      },
    }
    return opts
  end,
}
