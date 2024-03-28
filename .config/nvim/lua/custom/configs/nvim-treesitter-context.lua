return {
  setup = function()
    require("treesitter-context").setup {
      enable = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "inner",
      mode = "topline",
      separator = nil,
      zindex = 20,
      on_attach = nil,
    }
  end,
}
