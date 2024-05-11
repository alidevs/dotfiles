local M = {}

M.nvimtree = {
  view = {
    adaptive_size = true,
  },
}

M.telescope = {
  extensions = {
    import = {
      insert_at_top = true,
      custom_languages = {
        {
          regex = [[(?m)^(?:from[ ]+(\S+)[ ]+)?import[ ]+(\S+)[ ]*\$]], -- Note the escaped $
          filetypes = { "python" },
          extensions = { "py" },
        },
      },
    },
  },
}

return M
