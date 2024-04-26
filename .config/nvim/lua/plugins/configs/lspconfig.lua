local config = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

local on_attach = config.on_attach
local capabilities = config.capabilities

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  root_dir = lspconfig.util.root_pattern(".venv", "docker-compose.yml", ".direnv"),
}

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

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    disableSuggestions = true,
  },
  filetypes = { "typescript", "typescriptreact" },
  -- root_dir = lspconfig.util.root_pattern "package.json",
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

-- lspconfig.stylua.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "lua" },
--   root_dir = lspconfig.util.root_pattern ".stylua.toml",
-- }
