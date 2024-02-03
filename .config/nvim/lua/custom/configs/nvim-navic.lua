local navic = require("nvim-navic")

require("lspconfig").pyright.setup({
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
  end,
})
