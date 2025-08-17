local util = require("conform.util")

return {
  "stevearc/conform.nvim",
  opts = function()
    ---@type conform.setupOpts
    local opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        php = function(bufnr)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local dir = vim.fs.dirname(filename)

          local found = vim.fs.find(function(name)
            return name == ".php-cs-fixer.php" or name == ".php-cs-fixer.dist.php"
          end, {
            upward = true,
            path = dir,
            type = "file",
          })

          if found and #found > 0 then
            return { "php" }
          else
            return { "pint" }
          end
        end,
        blade = { "blade-formatter", "rustywind" },
        yaml = { "yamlfix" },
        python = {
          "ruff_fix",
          "ruff_format",
          "ruff_organize_imports"
        },
        json = { "biome" },
        jsonc = { "biome" },
        typescriptreact = { "biome" },
        typescript = { "biome" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        css = { "prettier" },
        html = { "prettier" },
        go = { "gofmt" },
        toml = { "taplo" },
        sql = { "pg_format" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        php = function(bufnr)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local dir = vim.fs.dirname(filename)

          local found = vim.fs.find(function(name)
            return name == ".php-cs-fixer.php" or name == ".php-cs-fixer.dist.php"
          end, {
            upward = true,
            path = dir,
            type = "file",
          })

          if found and #found > 0 then
            vim.notify("Using php-cs-fixer: " .. found[1])
            return {
              command = util.find_executable({
                "vendor/bin/php-cs-fixer",
                vim.fn.stdpath("data") .. "/mason/bin/php-cs-fixer",
                "php-cs-fixer",
              }, "php-cs-fixer"),
              args = { "fix", "$FILENAME" },
              stdin = false,
            }
          else
            vim.notify("Falling back to pint")
            return {
              command = util.find_executable({
                "vendor/bin/pint",
                vim.fn.stdpath("data") .. "/mason/bin/pint",
                "pint",
              }, "pint"),
              args = { "$FILENAME" },
              stdin = false,
            }
          end
        end,
        pint = {
          meta = {
            url = "https://github.com/laravel/pint",
            description = "Laravel Pint is an opinionated PHP code style fixer for minimalists.",
          },
          command = require("conform.util").find_executable({
            vim.fn.stdpath("data") .. "/mason/bin/pint",
            "vendor/bin/pint",
            "pint",
          }, "pint"),
          args = { "--config", vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h") .. "/pint.json", "$FILENAME" },
          stdin = false,
        },
        yamlfix = function()
          return {
            env = {
              YAMLFIX_SEQUENCE_STYLE = "block_style",
              YAMLFIX_WHITELINES = "1",
              YAMLFIX_quote_representation = "\"",
              YAMLFIX_SECTION_WHITELINES = "2",
              YAMLFIX_quote_basic_values = "true",
              YAMLFIX_LINE_LENGTH = "120",
            },
          }
        end,
      },
    }
    return opts
  end,
}
