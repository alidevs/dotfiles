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
map("n", "<leader>tt", function() require("base46").toggle_transparency() end, { desc = "Toggle transparency" })
