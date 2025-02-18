local M = {}

M.nvimtree = {
  view = {
    adaptive_size = true,
  },
}

M.luasnip = function(opts)
  require("luasnip").config.set_config(opts)
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/nvim/snippets" } }
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.blade.php" },
  callback = function()
    vim.bo.filetype = "html"
  end,
})

return M
