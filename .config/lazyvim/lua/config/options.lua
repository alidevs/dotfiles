vim.g.snacks_animate = false

vim.g.lazyvim_php_lsp = "intelephense"
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_picker = "fzf"

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true

vim.o.wrap = true

-- colors
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "JetbrainsMono Nerd Font:h13"
  vim.g.neovide_refresh_rate = 240
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_opacity = 1.0
end

vim.api.nvim_command("set colorcolumn=120")

vim.opt.wildignore:append({
  "*/node_modules/*",
  "*/dist/*",
  "*/target/*",
  "*/.git/*",
  "*/.next/*",
  "*/build/*"
})


vim.api.nvim_set_hl(0, "CustomIndentActive", { fg = "#E5C07B" })
