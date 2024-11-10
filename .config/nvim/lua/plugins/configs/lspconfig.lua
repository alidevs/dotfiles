local config = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

local on_attach = config.on_attach
local capabilities = config.capabilities

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "terraform-ls" },
}

lspconfig.basedpyright.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  capabilities = capabilities,
  filetypes = { "python" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      typeCheckingMode = "basic",
    },
  },
}

lspconfig.ruff.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  cmd = { "ruff", "server", "--preview" },
}

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

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = {
        kubernetes = "*.{yaml,yml}",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/github-action.json"] = "/.github/action/*.{yml,yaml}",
      },
    },
  },
}
