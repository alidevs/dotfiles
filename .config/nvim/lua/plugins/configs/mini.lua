return {
  setup = function()
    require("mini.pairs").setup {}
    require("mini.surround").setup {}
    require("mini.move").setup {}
    require("mini.ai").setup {}
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
      end,
    })
  end,
}
