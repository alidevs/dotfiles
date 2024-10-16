require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Noice
map("n", "<leader>nd", "<cmd>NoiceDismiss<cr>", { desc = "Dismiss noice" })

-- Telescope
map("n", "<leader><Tab>", "<cmd>Telescope oldfiles cwd_only=true<cr>", { desc = "Open recent files" })
map("n", "<leader>fy", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })
map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Search for string" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find in buffer" })

-- gitsigns
map("n", "]c", "<cmd>lua require('gitsigns').next_hunk()<cr>", { desc = "Next hunk" })
map("n", "[c", "<cmd>lua require('gitsigns').prev_hunk()<cr>", { desc = "Previous hunk" })
map("n", "<leader>gb", "<cmd>lua require('gitsigns').blame_line()<cr>", { desc = "Blame line" })
map("n", "<leader>rh", "<cmd>lua require('gitsigns').reset_hunk()<cr>", { desc = "Reset hunk" })
map("n", "<leader>ph", "<cmd>lua require('gitsigns').preview_hunk()<cr>", { desc = "Preview hunk" })

-- Lazygit
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- LSP & utils
map("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select virtualenv" })
map("n", "<leader>vc", "<cmd>VenvSelectCached<cr>", { desc = "Select cached virtualenv" })

-- Buffers
map("n", "<leader>kw", "<cmd>bufdo bd<cr>", { desc = "Close all buffers" })

-- Spectre
map("n", "<leader>S", "<cmd>lua require('spectre').toggle()<cr>", { desc = "Toggle Spectre" })
map("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", { desc = "Search current word" })
map("v", "<leader>sw", "<esc><cmd>lua require('spectre').open_visual()<CR>", { desc = "Search current word" })

-- Transparent
map("n", "<leader>tt", "<cmd>lua require('base46').toggle_transparency()<cr>", { desc = "Toggle transparency" })

-- Neovide
local function neovide_scale(amount)
  local temp = vim.g.neovide_scale_factor + amount

  if temp < 0.5 then
    return
  end
  vim.g.neovide_scale_factor = temp
end

map("n", "<C-=>", function()
  neovide_scale(0.1)
end, { desc = "Increase scale factor" })

map("n", "<C-->", function()
  neovide_scale(-0.1)
end, { desc = "Decrease scale factor" })

-- Menu
map("n", "<C-t>", function()
  require("menu").open "default"
end, { desc = "Open default menu" })
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, { desc = "Open menu" })
