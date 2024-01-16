---@type ChadrcConfig
local M = {}

-- M.ui = { theme = 'catppuccin' }
M.ui = {
  changed_themes = {
    catppuccin = {
      theme = 'catppuccin',
      transparent = false,
      styles = {
        comments = 'italic',
        functions = 'italic',
        keywords = 'italic',
        strings = 'NONE',
        variables = 'NONE',
      }
    }
  },
  statusline = {
    separator_style = 'arrow',
  },
  nvdash = {
    load_on_startup = true,
  }
}
M.plugins = 'custom.plugins'
return M
