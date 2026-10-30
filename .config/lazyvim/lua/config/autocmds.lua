-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "active_cursorline",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- clear a client's diagnostics on detach; nvim otherwise leaves stale
-- diagnostics from the old client stacked on top of the new one's after
-- any LSP restart (gopls crash/reattach, :LspRestart, buffer close/reopen)
vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("clear_diagnostics_on_detach", { clear = true }),
  callback = function(args)
    local ns = vim.lsp.diagnostic.get_namespace(args.data.client_id)
    vim.diagnostic.reset(ns, args.buf)
  end,
})
