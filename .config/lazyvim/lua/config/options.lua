vim.g.snacks_animate = false

vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true

-- colors
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "JetbrainsMono Nerd Font:h13"
  vim.g.neovide_refresh_rate = 175
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_transparency = 1.0
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
end

vim.api.nvim_command("set colorcolumn=120")
vim.api.nvim_command("set scrolloff=8")
