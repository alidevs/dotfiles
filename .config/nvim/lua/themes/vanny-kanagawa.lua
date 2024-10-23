local M = {}

M.base_30 = {
  white = "#DCD7BA",
  darker_black = "#16161D",
  black = "#1F1F28", --  nvim bg
  black2 = "#2A2A37",
  one_bg = "#363646",
  one_bg2 = "#54546D",
  one_bg3 = "#727169",
  grey = "#727169",
  grey_fg = "#938AA9",
  grey_fg2 = "#9CABCA",
  light_grey = "#717C7C",
  red = "#FF5D62",
  baby_pink = "#D27E99",
  pink = "#D27E99",
  line = "#2A2A37", -- for lines like vertsplit
  green = "#98BB6C",
  vibrant_green = "#98BB6C",
  nord_blue = "#7E9CD8",
  blue = "#7FB4CA",
  yellow = "#E6C384",
  sun = "#E6C384",
  purple = "#957FB8",
  dark_purple = "#957FB8",
  teal = "#7AA89F",
  orange = "#FFA066",
  cyan = "#7AA89F",
  statusline_bg = "#1F1F28",
  lightbg = "#2A2A37",
  pmenu_bg = "#7E9CD8",
  folder_bg = "#7E9CD8",
}

M.base_16 = {
  base00 = "#16161D",
  base01 = "#2A2A37",
  base02 = "#223249",
  base03 = "#363646",
  base04 = "#54546D",
  base05 = "#DCD7BA",
  base06 = "#C8C093",
  base07 = "#C8C093",
  base08 = "#C34043",
  base09 = "#FFA066",
  base0A = "#C0A36E",
  base0B = "#76946A",
  base0C = "#6A9589",
  base0D = "#7E9CD8",
  base0E = "#957FB8",
  base0F = "#D27E99",
}

M.type = "dark"

M = require("base46").override_theme(M, "kanagawa")

return M
