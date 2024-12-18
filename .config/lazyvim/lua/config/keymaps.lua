local map = LazyVim.safe_keymap_set

map("n", "<leader><Tab>", "<cmd>Telescope oldfiles cwd_only=true<cr>", { desc = "Open recent files" })
map("n", "<leader>kw", "<cmd>bufdo bd<cr>", { desc = "Close all buffers" })
