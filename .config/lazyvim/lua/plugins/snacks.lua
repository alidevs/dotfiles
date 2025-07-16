return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      dim = {
        scope = {
          min_size = 2,
          max_size = 20,
          siblings = true,
        }
      },
      indent = {
        enabled = true,

        chunk = {
          enabled = true,
          only_current = true,
          hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
      },
    },
  },
}
