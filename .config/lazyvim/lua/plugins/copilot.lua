return {
  {
    "zbirenbaum/copilot.lua",
    opts = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts or {}, {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<M-l>",
            accept_word = "<M-k>",
            accept_line = "<M-j>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          ["."] = false,
        },
      })
      return opts
    end,
  },
}
