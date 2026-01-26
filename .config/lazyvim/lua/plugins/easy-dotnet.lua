return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local dotnet = require("easy-dotnet")

    vim.keymap.set("n", "<leader>dnc", function()
      local bufname = vim.fn.expand("%:p")
      local start_dir
      if bufname:match("neo%-tree") or bufname == "" then
        start_dir = vim.fn.getcwd()
      else
        start_dir = vim.fn.expand("%:p:h")
      end
      local dir = start_dir
      local csproj
      while dir ~= "/" and dir ~= "" do
        local files = vim.fn.glob(dir .. "/*.csproj", false, true)
        if #files > 0 then
          csproj = files[1]
          break
        end
        dir = vim.fn.fnamemodify(dir, ":h")
      end
      if not csproj then
        vim.notify("No .csproj found from: " .. start_dir, vim.log.levels.WARN)
        return
      end
      dotnet.createfile(vim.fn.fnamemodify(csproj, ":h"))
    end, { desc = "Create C# file" })

    vim.keymap.set("n", "<leader>dnn", function()
      dotnet.new()
    end, { desc = "New dotnet template" })

    vim.keymap.set("n", "<leader>dnp", function()
      dotnet.project_view()
    end, { desc = "Project view" })

    vim.keymap.set("n", "<leader>dnr", function()
      dotnet.run()
    end, { desc = "Run project" })

    vim.keymap.set("n", "<leader>dnt", function()
      dotnet.testrunner()
    end, { desc = "Test runner" })

    vim.keymap.set("n", "<leader>dnb", function()
      dotnet.build_solution()
    end, { desc = "Build solution" })

    vim.keymap.set("n", "<leader>dna", function()
      dotnet.add_package()
    end, { desc = "Add NuGet package" })

    vim.keymap.set("n", "<leader>dns", function()
      dotnet.solution_add()
    end, { desc = "Add project to solution" })
  end,
}
