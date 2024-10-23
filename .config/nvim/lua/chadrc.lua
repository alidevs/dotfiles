-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  cmp = {
    lspkind_text = true,
    style = "default",
  },

  statusline = {
    theme = "default",
  },

  tabufline = {
    order = { "treeOffset", "buffers", "tabs" },
    lazyload = false,
    modules = {},
  },
}

M.base46 = {
  theme = "vanny-nightlamp",
  transparency = false,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    CursorLineNr = { fg = "yellow", bold = true },
    LspInlayHint = { fg = "#4e5665", bg = "NONE" },
    FloatTitle = { link = "Title" },
    FloatBorder = { link = "TelescopeBorder" },
    TelescopeSelection = { bg = { "black", -2 }, bold = true },
    NvimTreeRootFolder = { link = "TelescopeBorder" },
    NvimTreeGitDirty = { link = "NvimTreeNormal" },
    ["@keyword"] = { italic = true },
  },

  hl_add = {
    YankVisual = { link = "CursorColumn" },
    LspInfoBorder = { fg = "#444c5b" },
    WinBar = { bg = "NONE" },
    WinBarNC = { bg = "NONE" },
    DropBarMenuCurrentContext = { link = "Visual" },
    St_HarpoonInactive = { link = "StText" },
    St_HarpoonActive = { link = "St_LspHints" },
    NvimTreeGitStagedIcon = { fg = "#a6e3a1" },
    MarkviewLayer2 = { bg = "#171b21" },
    MarkviewCode = { link = "MarkviewLayer2" },
    HelpviewCode = { link = "MarkviewLayer2" },
    HelpviewInlineCode = { link = "MarkviewInlineCode" },
    HelpviewCodeLanguage = { link = "MarkviewCode" },
    CodeActionSignHl = { fg = "#f9e2af" },
    ["@markup.quote.markdown"] = { bg = "NONE" },
    ["@markup.raw.block.markdown"] = { link = "MarkviewLayer2" },
  },
}

return M
