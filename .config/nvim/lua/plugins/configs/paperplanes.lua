return {
  setup = function()
    require("rktjmp/paperplanes.nvim").setup(
      {
        register = "+",
        provider = "0x0.st",
        provider_options = {},
        notifier = vim.notify or print,
      }
    )
  end
}
