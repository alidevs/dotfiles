local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    toml = { "taplo" },
    rust = { "rustfmt" },
    ruby = { "rufo" },
    yaml = { "yamlfix" },
    json = { "fixjson" },
    typescript = { "biome" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_fix", "ruff_format", "ruff_organize_imports" }
      end
    end,
  },

  formatters = {
    yamlfix = function()
      return {
        env = {
          YAMLFIX_SEQUENCE_STYLE = "block_style",
          YAMLFIX_WHITELINES = "1",
        },
      }
    end,
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
