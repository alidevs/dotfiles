-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  cmp = { lspkind_text = false, style = "flat_dark" },

  statusline = { theme = "minimal", separator_style = "default" },

  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
    lazyload = false,
    modules = {},
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    CursorLineNr = { fg = "#F5DFAD", bold = true, italic = true },
  },
}

return M
