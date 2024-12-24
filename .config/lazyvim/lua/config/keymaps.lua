local map = LazyVim.safe_keymap_set

vim.keymap.del("n", "<leader><Tab>d")
vim.keymap.del("n", "<leader><Tab>f")
vim.keymap.del("n", "<leader><Tab>l")
vim.keymap.del("n", "<leader><Tab>o")
vim.keymap.del("n", "<leader><Tab>[")
vim.keymap.del("n", "<leader><Tab>]")
vim.keymap.del("n", "<leader><Tab><Tab>")

map("n", "<leader><Tab>", "<cmd>FzfLua oldfiles cwd_only=true include_current_session=true sort_mru=true<cr>",
  { desc = "Recent files" })

map("n", "<leader>kw", "<cmd>bufdo bd<cr>", { desc = "Close all buffers" })

map("n", "<leader>la", ":Laravel artisan<cr>", { desc = "Laravel artisan" })
map("n", "<leader>lr", ":Laravel routes<cr>", { desc = "Laravel routes" })
map("n", "<leader>lm", ":Laravel related<cr>", { desc = "Laravel related" })
map("n", "<leader>lc", ":Laravel composer<cr>", { desc = "Laravel composer" })
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
