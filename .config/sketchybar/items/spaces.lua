local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Highlight the focused space and collapse its app-icon strip (port of space.sh)
local function space_selection(env)
  local selected = env.SELECTED == "true"
  local width = selected and 0 or "dynamic"
  sbar.animate("tanh", 15, function()
    sbar.set(env.NAME, {
      icon = { highlight = selected },
      label = { width = width },
    })
  end)
end

-- Left click focuses, right click destroys the space (port of space.sh)
local function space_click(env)
  if env.BUTTON == "right" then
    sbar.exec("yabai -m space --destroy " .. env.SID)
    sbar.trigger("space_change")
    sbar.trigger("windows_on_spaces")
  else
    sbar.exec("yabai -m space --focus " .. env.SID .. " 2>/dev/null")
  end
end

local space_names = {}
for sid = 1, 15, 1 do
  local name = "space." .. sid
  space_names[sid] = name

  local space = sbar.add("space", name, {
    associated_space = sid,
    icon = {
      string = tostring(sid),
      padding_left = 10,
      padding_right = 15,
      highlight_color = colors.red,
    },
    padding_left = 2,
    padding_right = 2,
    label = {
      padding_right = 20,
      -- App-icon strip, populated by yabai.sh (windows_on_spaces)
      font = settings.app_font,
      background = {
        height = 26,
        drawing = true,
        color = colors.bg2,
        corner_radius = 8,
      },
      drawing = false,
    },
  })

  space:subscribe("space_change", space_selection)
  space:subscribe("mouse.clicked", space_click)
end

-- Bracket that draws the rounded background behind all spaces
sbar.add("bracket", "spaces", space_names, {
  background = {
    color = colors.bg1,
    border_color = colors.bg2,
    border_width = 1,
    corner_radius = 8,
    height = 32,
    drawing = true,
  },
})

-- Separator that creates a new yabai space on click
local separator = sbar.add("item", "separator", {
  icon = {
    string = icons.separator,
    font = {
      family = settings.font,
      style = "Heavy",
      size = 16.0,
    },
    color = colors.white,
  },
  padding_left = 15,
  padding_right = 15,
  label = { drawing = false },
  associated_display = "active",
})

separator:subscribe("mouse.clicked", function(_)
  sbar.exec("yabai -m space --create")
  sbar.trigger("space_change")
end)
