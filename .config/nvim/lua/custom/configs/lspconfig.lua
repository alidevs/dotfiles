local config = require("plugins.configs.lspconfig")
local lspconfig = require("lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local servers = {}

servers["pyright"] = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
  root_dir = lspconfig.util.root_pattern(".venv", "docker-compose.yml", ".direnv")
}

servers["rust_analyzer"] = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  }
}

servers["stylua"] = {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"lua"},
  root_dir = lspconfig.util.root_pattern(".stylua.toml")
}

for lsp, config in pairs(servers) do
  lspconfig[lsp].setup(config)
end
