local config = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

local on_attach = config.on_attach
local capabilities = config.capabilities

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  root_dir = lspconfig.util.root_pattern(".venv", "docker-compose.yml", ".direnv"),
  handlers = {
    -- ["textDocument/publishDiagnostics"] = function(...) end,
  },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
  },
  python = {
    analysis = {
      ignore = { diagnosticMode = "off", typeCheckingMode = "off" },
    },
  },
}

lspconfig.ruff.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  cmd = { "ruff", "server", "--preview" },
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  filetypes = { "typescript" },
  root_dir = lspconfig.util.root_pattern "package.json",
}

lspconfig.sorbet.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "ruby" },
  root_dir = lspconfig.util.root_pattern "Gemfile",
  cmd = { "bundle", "exec", "srb", "tc", "--lsp", "--disable-watchman", "--typed", "true" },
  init_options = {
    highlightUntyped = true,
  },
}
