return {
  setup = function()
    require("mini.pairs").setup {}
    require("mini.surround").setup {}
    require("mini.move").setup {}
    require("mini.indentscope").setup {
      symbol = "▏",
      options = { try_as_border = true },
    }
    -- Additional setup for disabling in specific filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
