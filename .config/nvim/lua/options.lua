require "nvchad.options"

local o = vim.o
o.cursorlineopt = "both"

local opt = vim.opt
opt.relativenumber = true
opt.spell = true
opt.spelllang = "en_us"

opt.title = true
opt.titlelen = 0
opt.titlestring = "NeoVim - %{expand('%:~:.')}"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true


local g = vim.g
-- Neovide
if g.neovide then
  o.guifont = "JetbrainsMono Nerd Font:h13"

  g.neovide_refresh_rate = 175

  g.neovide_cursor_vfx_mode = "railgun"
end


vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
  end,
})
