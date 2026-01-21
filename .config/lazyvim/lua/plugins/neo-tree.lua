return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.window = opts.window or {}
      opts.window.mappings = opts.window.mappings or {}

      opts.window.mappings["Y"] = function(state)
        local node = state.tree:get_node()
        local path = node and node.path or nil
        if not path then
          vim.notify("No path to copy", vim.log.levels.WARN)
          return
        end

        local cwd = state.path or vim.fn.getcwd()
        local rel_path = vim.fn.fnamemodify(path, ":.")
        vim.fn.setreg("+", rel_path)
        vim.notify("Copied relative path: " .. rel_path)
      end

      opts.window.mappings["N"] = function(state)
        local node = state.tree:get_node()
        local path = node and node.path or nil
        if not path then
          return
        end
        if node.type ~= "directory" then
          path = vim.fn.fnamemodify(path, ":h")
        end
        require("easy-dotnet").createfile(path)
      end
    end,
  },
}
