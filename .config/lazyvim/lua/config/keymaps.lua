local map = LazyVim.safe_keymap_set

map("n", "<leader><Tab>", "<cmd>Telescope oldfiles cwd_only=true<cr>", { desc = "Open recent files" })
map("n", "<leader>kw", "<cmd>bufdo bd<cr>", { desc = "Close all buffers" })

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
