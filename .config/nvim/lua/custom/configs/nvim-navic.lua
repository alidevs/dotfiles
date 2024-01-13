local navic = require("nvim-navic")

require("lspconfig").pyright.setup({
  on_attach = function(client)
    navic.attach(client)
  end,
})
