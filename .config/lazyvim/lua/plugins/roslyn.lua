return {
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },

  { "Hoffs/omnisharp-extended-lsp.nvim", enabled = false },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = { enabled = false },
      },
    },
  },

  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cs",
        callback = function(args)
          vim.b[args.buf].autoformat = false
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or client.name ~= "roslyn" then
            return
          end

          local bufnr = args.buf
          local augroup = vim.api.nvim_create_augroup("FormatCSharpModifications", { clear = false })
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              local gitsigns = require("gitsigns")
              local hunks = gitsigns.get_hunks()
              if not hunks or #hunks == 0 then
                return
              end

              local hunk_lines = {}
              for _, hunk in ipairs(hunks) do
                if hunk.added.count > 0 then
                  for l = hunk.added.start, hunk.added.start + hunk.added.count - 1 do
                    hunk_lines[l] = true
                  end
                end
              end

              local original_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

              vim.lsp.buf.format({ bufnr = bufnr, async = false })

              local formatted_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

              if #original_lines == #formatted_lines then
                for i = 1, #original_lines do
                  if not hunk_lines[i] and original_lines[i] ~= formatted_lines[i] then
                    formatted_lines[i] = original_lines[i]
                  end
                end
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)
              end
            end,
          })
        end,
      })
    end,
    config = function(_, opts)
      require("roslyn").setup(opts)
    end,
  },
}
