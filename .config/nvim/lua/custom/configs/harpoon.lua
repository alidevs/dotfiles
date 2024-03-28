local M = {}

function M.setup()
  local harpoon = require "harpoon"
  harpoon.setup {}

  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table {
          results = file_paths,
        },
        sorter = conf.generic_sorter {},
        previewer = conf.file_previewer {},
      })
      :find()
  end

  vim.keymap.set("n", "<leader>e", function()
    toggle_telescope(harpoon.mark)
  end, { desc = "Open harpoon window" })
  vim.keymap.set("n", "<leader>m", function()
    harpoon.mark.add_file()
  end, { desc = "Add current file to harpoon" })
  vim.keymap.set("n", "<leader>md", function()
    harpoon.mark.remove_file()
  end, { desc = "Delete current file from harpoon" })
  vim.keymap.set("n", "<leader>]", function()
    harpoon.ui.nav_next()
  end, { desc = "Navigate to next file in harpoon" })
  vim.keymap.set("n", "<leader>[", function()
    harpoon.ui.nav_prev()
  end, { desc = "Navigate to previous file in harpoon" })
end

return M
