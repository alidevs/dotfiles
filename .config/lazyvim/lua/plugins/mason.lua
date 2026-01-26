return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruff",
        "biome",
        "pint",
        "prettier",
        "yamlfix",
        "ty",
        "csharpier",
      })
    end,
  }
}
