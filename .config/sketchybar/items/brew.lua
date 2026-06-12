local colors = require("colors")
local icons = require("icons")

-- Trigger brew_update from your shell (e.g. a function in .zshrc) after
-- running `brew update`/`upgrade` to refresh this immediately.
sbar.add("event", "brew_update")

local brew = sbar.add("item", "brew", {
  position = "right",
  icon = { string = icons.brew },
  label = { string = "?" },
  padding_right = 10,
  update_freq = 300,
})

local function brew_update()
  local cmd = 'export PATH="/opt/homebrew/bin:$PATH"; '
    .. "export HOMEBREW_NO_AUTO_UPDATE=1; "
    .. "export HOMEBREW_DOWNLOAD_CONCURRENCY=4; "
    .. "brew outdated --quiet 2>/dev/null | grep -c '.'"

  sbar.exec(cmd, function(result)
    local count = tonumber((result:gsub("%s+", ""))) or 0
    local color = colors.red
    local label = tostring(count)

    if count == 0 then
      color = colors.green
      label = icons.check
    elseif count < 10 then
      color = colors.white
    elseif count < 30 then
      color = colors.yellow
    elseif count < 60 then
      color = colors.orange
    end

    brew:set({ label = label, icon = { color = color } })
  end)
end

brew:subscribe({ "routine", "forced", "brew_update" }, brew_update)
