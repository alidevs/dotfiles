return {
  setup = function()
    require("mason").setup {
      ensure_installed = {
        "pyright",
        "mypy",
        "rust-analyzer",
        "black",
        "isort",
        "flake8",
      },
    }
  end,
}
