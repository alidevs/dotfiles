return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
    ft = { "cs", "fsharp", "vb" },
    opts = {
      picker = "fzf",
    },
  },
}
