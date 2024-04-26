require "nvchad.options"

local o = vim.o
o.cursorlineopt = 'both'

local opt = vim.opt
opt.relativenumber = true

opt.title = true
opt.titlelen = 0
opt.titlestring = "NeoVim - %{expand('%:~:.')}"

local g = vim.g
-- Neovide
if g.neovide then
  o.guifont = "JetbrainsMono Nerd Font:h12"

  g.neovide_refresh_rate = 175

  g.neovide_cursor_vfx_mode = "railgun"
end
