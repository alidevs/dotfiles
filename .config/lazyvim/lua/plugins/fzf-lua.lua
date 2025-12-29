return {
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts, {
        winopts = {
          width = 0.9,
          height = 0.9,
        },
      })
      return opts
    end,
    keys = {
      -- Disable the FzfLua "gd" mapping only for C# / Razor
      { "gd", false, ft = { "cs", "razor" } },
    },
  },
}
