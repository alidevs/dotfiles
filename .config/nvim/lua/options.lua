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

  g.neovide_transparency = 0.75

  g.neovide_input_macos_option_key_is_meta = "only_left"
end

g.vscode_snippets_path = "~/.config/nvim/snippets/json"
g.lua_snippets_path = "~/.config/nvim/snippets/lua"

-- Other
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.diagnostic.config {
      virtual_text = false,
    }
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.api.nvim_command "set colorcolumn=120"
    vim.api.nvim_command "set scrolloff=8"
    vim.api.nvim_command "set termbidi"
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})
