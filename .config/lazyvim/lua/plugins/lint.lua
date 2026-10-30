return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = {},
      },
      -- golangci-lint has no built-in go.mod discovery relative to the
      -- buffer; nvim-lint runs it from vim.fn.getcwd() by default, which is
      -- the repo root (no go.mod there) -- point it at backend/ instead.
      linters = {
        golangcilint = {
          cwd = vim.fn.filereadable(vim.fn.getcwd() .. "/backend/go.mod") == 1
              and (vim.fn.getcwd() .. "/backend")
            or vim.fn.getcwd(),
        },
      },
    },
  },
}
