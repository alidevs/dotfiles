vim.g.snacks_animate = false

vim.g.lazyvim_php_lsp = "intelephense"
-- vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_picker = "fzf"

-- search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true

-- Swapfile
vim.opt.swapfile = false

vim.o.wrap = true

-- colors
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "JetbrainsMono Nerd Font:h15"
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
  "*/build/*",
})

vim.filetype.add({
  filename = {
    ["env"] = "sh",
    ["envs"] = "sh",
  },
})

vim.api.nvim_set_hl(0, "CustomIndentActive", { fg = "#9CCFD8" })

vim.g["db#client_mysql_command"] = "mariadb"

-- Disable diagnostics for certain file types
vim.api.nvim_create_autocmd({ "LspAttach", "BufReadPost", "BufNewFile" }, {
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")

    local disabled_filetypes = { "markdown", "json" }
    local disabled_files = { ".env", ".env.example", "env", "envs" }

    if vim.tbl_contains(disabled_filetypes, ft) or vim.tbl_contains(disabled_files, filename) then
      -- disable diagnostics for this buffer
      vim.diagnostic.enable(false, { bufnr = bufnr })
    end
  end,
})

vim.lsp.config("ty", {
  settings = { ty = {} },
})

vim.lsp.enable("ty")
