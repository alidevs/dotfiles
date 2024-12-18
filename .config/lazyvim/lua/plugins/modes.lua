return {
  {
    "mvllow/modes.nvim",
    tag = "v0.2.0",
    event = "VeryLazy",
    config = function()
      require("modes").setup({
        colors = {
          bg = "", -- Optional bg param, defaults to Normal hl group
          copy = "#f5c359",
          delete = "#c75c6a",
          insert = "#588157",
          visual = "#8ecae6",
        },
      })
    end,
  },
}
