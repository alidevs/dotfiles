require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Noice
map("n", "<leader>nd", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss noice" })

-- Telescope
map("n", "<leader><leader>", "<cmd>Telescope frecency workspace=CWD<cr>", { desc = "Frecent files" })
map("n", "<leader><Tab>", "<cmd>Telescope oldfiles cwd_only=true<cr><ESC>", { desc = "Open recent files" })
map("n", "<leader>fy", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })
map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Search for string" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find in buffer" })

-- base46
map("n", "<leader>tt", function()
  require("base46").toggle_transparency()
end, { desc = "Toggle transparency" })

-- gitsigns
map("n", "]c", "<cmd>lua require('gitsigns').next_hunk()<cr>", { desc = "Next hunk" })
map("n", "[c", "<cmd>lua require('gitsigns').prev_hunk()<cr>", { desc = "Previous hunk" })

-- Lazygit
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- LSP & utils
map("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select virtualenv" })
map("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", { desc = "Select cached virtualenv" })
