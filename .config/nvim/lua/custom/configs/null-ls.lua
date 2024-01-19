local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require('null-ls')

local opts = {
  sources = {
    null_ls.builtins.formatting.black.with({
      extra_args = { "--line-length", "120" },
    }),
    null_ls.builtins.diagnostics.flake8.with({
      extra_args = { "--import-order-style", "google", "--max-line-length", "140", "--ignore", "E203", "--exclude", "env.py" },
    }),
    null_ls.builtins.formatting.isort.with({
      extra_args = { "--profile", "black", "--line-length", "120" },
    }),
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = { "--ignore-missing-imports", "--exclude", "alembic/*"},
    }),
    -- null_ls.builtins.diagnostics.ruff
  },
  on_attach = function (client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}

return opts
