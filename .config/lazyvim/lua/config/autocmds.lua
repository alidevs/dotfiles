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

local group = vim.api.nvim_create_augroup("CSharpNativeGd", { clear = true })

vim.api.nvim_create_autocmd({ "LspAttach", "BufEnter" }, {
  group = group,
  callback = function(ev)
    local buf = ev.buf or vim.api.nvim_get_current_buf()
    local ft = vim.bo[buf].filetype
    if ft ~= "cs" and ft ~= "razor" then return end

    -- Run after everything else that might (re)set keymaps
    vim.schedule(function()
      pcall(vim.keymap.del, "n", "gd", { buffer = buf })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
        buffer = buf,
        desc = "Goto Definition (native LSP)",
      })
    end)
  end,
})
