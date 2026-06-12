local colors = require("colors")
local settings = require("settings")

local cal = sbar.add("item", "calendar", {
  position = "right",
  icon = {
    string = "cal",
    padding_right = 0,
    font = {
      family = settings.font,
      style = "Black",
      size = 12.0,
    },
  },
  label = {
    width = 90,
    align = "right",
  },
  padding_left = 15,
  update_freq = 1,
})

local function update()
  cal:set({
    icon = os.date("%a %d. %b"),
    label = os.date("%I:%M:%S %p"),
  })
end

cal:subscribe({ "routine", "forced", "system_woke" }, update)

-- Zen mode: hide most items for a distraction-free bar (port of zen.sh)
local zen_enabled = false

local function set_zen(on)
  local visible = not on
  sbar.set("/cpu.*/", { drawing = visible })
  sbar.set("calendar", { icon = { drawing = visible } })
  sbar.set("yabai", { drawing = visible })
  sbar.set("separator", { drawing = visible })
  sbar.set("front_app", { drawing = visible })
  sbar.set("volume_icon", { drawing = visible })
  sbar.set("brew", { drawing = visible })
  sbar.set("spotify.play", { updates = visible })
  if on then
    sbar.set("spotify.anchor", { drawing = false })
  end
end

cal:subscribe("mouse.clicked", function(_)
  zen_enabled = not zen_enabled
  set_zen(zen_enabled)
end)
