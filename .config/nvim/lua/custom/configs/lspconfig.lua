local config = require "plugins.configs.lspconfig"
local lspconfig = require "lspconfig"

local on_attach = config.on_attach
local capabilities = config.capabilities

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  root_dir = lspconfig.util.root_pattern(".venv", "docker-compose.yml", ".direnv"),
}

-- lspconfig.pylsp.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "python" },
--   root_dir = lspconfig.util.root_pattern(".venv", "docker-compose.yml", ".direnv"),
--   settings = {
--     pylsp = {
--       plugins = {
--         black = { enabled = true },
--         pylsp_mypy = { enabled = true },
--         pylsp_isort = { enabled = true },
--         flake8 = { enabled = true },
--         pycodestyle = {
--           maxLineLength = 120,
--         },
--       },
--     },
--   },
-- }

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

-- lspconfig.stylua.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "lua" },
--   root_dir = lspconfig.util.root_pattern ".stylua.toml",
-- }
