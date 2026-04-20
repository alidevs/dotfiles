return {
  -- Disable omnisharp since roslyn.nvim replaces it
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          enabled = false,
        },
      },
    },
  },

  -- Add custom mason registry for roslyn LSP binary
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ensure_installed = { "roslyn" },
    },
  },

  -- Roslyn LSP plugin for C#/.NET
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {},
  },
}
