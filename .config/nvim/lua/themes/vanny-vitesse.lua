local M = {}

M.base_30 = {
  white = "#c8c5b8",
  black = "#121212", -- usually your theme bg
  darker_black = "#0f0f0f", -- 6% darker than black
  black2 = "#181818", -- 6% lighter than black
  one_bg = "#222222", -- 10% lighter than black
  one_bg2 = "#292929", -- 6% lighter than one_bg2
  one_bg3 = "#393939", -- 6% lighter than one_bg3
  grey = "#4d4d4d", -- 40% lighter than black (the % here depends so choose the perfect grey!)
  grey_fg = "#5c6b5e", -- 10% lighter than grey
  grey_fg2 = "#666666", -- 5% lighter than grey
  light_grey = "#83827d",
  red = "#cb7676",
  baby_pink = "#d9739f",
  pink = "#d9739f",
  line = "#252525", -- 15% lighter than black (for lines like vertsplit)
  green = "#4d9375",
  vibrant_green = "#80a665",
  nord_blue = "#5da9a7",
  blue = "#6394bf",
  yellow = "#e6cc77", -- 8% lighter than yellow
  sun = "#d4976c",
  purple = "#bd8f8f",
  dark_purple = "#5a32a3",
  teal = "#5eaab5",
  orange = "#d4976c",
  cyan = "#5eaab5",
  statusline_bg = "#181818",
  lightbg = "#252525",
  pmenu_bg = "#4d9375",
  folder_bg = "#6394bf",
}

M.base_16 = {
  base00 = "#121212",
  base01 = "#181818",
  base02 = "#252525",
  base03 = "#393939",
  base04 = "#4d4d4d",
  base05 = "#c8c5b8",
  base06 = "#d7d7d7",
  base07 = "#ffffff",
  base08 = "#cb7676",
  base09 = "#d4976c",
  base0A = "#e6cc77",
  base0B = "#4d9375",
  base0C = "#5eaab5",
  base0D = "#6394bf",
  base0E = "#d9739f",
  base0F = "#bd8f8f",
}

M.type = "dark"

M = require("base46").override_theme(M, "vanny-vitesse")

return M
