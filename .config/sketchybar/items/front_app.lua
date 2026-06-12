local colors = require("colors")
local settings = require("settings")

local plugin_dir = os.getenv("HOME") .. "/.config/sketchybar/plugins"

-- Custom events triggered by the user's yabai signals
sbar.add("event", "window_focus")
sbar.add("event", "windows_on_spaces")

-- Yabai window-state indicator (float / stack / zoom / grid).
-- The heavy yabai+jq querying and per-space app-icon strips stay in yabai.sh,
-- driven via the shell `script` property.
local yabai = sbar.add("item", "yabai", {
  icon = { drawing = false },
  label = { drawing = false },
  associated_display = "active",
  script = plugin_dir .. "/yabai.sh",
})

yabai:subscribe({ "window_focus", "windows_on_spaces", "mouse.clicked" })

-- Focused application name + app icon
local front_app = sbar.add("item", "front_app", {
  icon = {
    drawing = true,
    font = settings.app_font,
    color = colors.orange,
  },
  padding_left = 0,
  label = {
    color = colors.white,
    font = {
      family = settings.font,
      style = "Black",
      size = 12.0,
    },
  },
  associated_display = "active",
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({ label = { string = env.INFO } })
  sbar.exec(plugin_dir .. "/icon_map.sh \"" .. env.INFO .. "\"", function(icon)
    front_app:set({ icon = { string = icon:gsub("%s+$", "") } })
  end)
end)
