return {
  "supermaven-inc/supermaven-nvim",
  lazy = false,
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_word = "<C-w>",
        next_suggestion = "<C-n>",
        previous_suggestion = "<C-p>",
        select_suggestion = "<CR>",
        clear_suggestion = "<C-c>"
      }
    })
  end,
}
