require "nvchad.options"

local o = vim.o
o.cursorlineopt = "both"

local opt = vim.opt
opt.relativenumber = true
opt.spell = true
opt.spelllang = "en_us"

opt.title = true
opt.titlelen = 0
opt.titlestring = "NeoVim - %{expand('%:~:.')}"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

local g = vim.g
-- Neovide
if g.neovide then
  o.guifont = "JetbrainsMono Nerd Font:h13"

  g.neovide_refresh_rate = 175

  g.neovide_cursor_vfx_mode = "railgun"

  g.neovide_transparency = 1.0

  g.neovide_input_macos_option_key_is_meta = "only_left"
end

g.vscode_snippets_path = "~/.config/nvim/snippets/json"
g.lua_snippets_path = "~/.config/nvim/snippets/lua"

-- Other
vim.api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.diagnostic.config {
      virtual_text = false,
    }
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    local api = vim.api
    api.nvim_command "set colorcolumn=120"
    api.nvim_command "set scrolloff=8"
    api.nvim_command "set termbidi"
    api.nvim_command "set nomagic"
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == "ruff" then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " " or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
