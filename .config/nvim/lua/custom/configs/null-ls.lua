local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local opts = {
  sources = {
    -- Python
    null_ls.builtins.formatting.black.with {
      extra_args = { "--config", vim.fn.findfile(".python-black", ".;") },
    },
    null_ls.builtins.diagnostics.flake8.with {
      extra_args = { "--config-file", vim.fn.findfile("tox.ini", ".;") },
    },
    null_ls.builtins.formatting.isort.with {
      extra_args = { "--settings-path", vim.fn.findfile(".github/linters/tox.ini", ".;") },
    },
    null_ls.builtins.diagnostics.mypy.with {
      extra_args = { "--config-file", vim.fn.findfile("tox.ini", ".;") },
    },

    -- Lua
    null_ls.builtins.formatting.stylua,

    -- Others
    -- null_ls.builtins.formatting.prettierd.with {
    --   filetypes = { "json", "yaml", "markdown", "html", "css" },
    -- },
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

return opts
