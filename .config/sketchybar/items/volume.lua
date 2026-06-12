local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local function hex(color)
  return string.format("0x%08x", color)
end

local volume_slider = sbar.add("slider", "volume", 100, {
  position = "right",
  updates = true,
  label = { drawing = false },
  icon = { drawing = false },
  slider = {
    highlight_color = colors.orange,
    width = 0,
    background = {
      height = 5,
      corner_radius = 3,
      color = colors.bg2,
    },
    knob = {
      string = "􀀁",
      drawing = false,
    },
  },
})

local volume_icon = sbar.add("item", "volume_icon", {
  position = "right",
  padding_left = 10,
  padding_right = 0,
  icon = {
    string = icons.volume._100,
    width = 0,
    align = "left",
    color = colors.grey,
    font = {
      family = settings.font,
      style = "Regular",
      size = 14.0,
    },
  },
  label = {
    width = 25,
    align = "left",
    font = {
      family = settings.font,
      style = "Regular",
      size = 14.0,
    },
  },
})

-- Status bracket around the right-side status items
sbar.add("bracket", "status", { "volume_icon", "battery", "brew" }, {
  background = {
    color = colors.bg1,
    border_color = colors.bg2,
    border_width = 2,
  },
})

local function icon_for(volume)
  if volume > 60 then
    return icons.volume._100
  elseif volume > 30 then
    return icons.volume._66
  elseif volume > 10 then
    return icons.volume._33
  elseif volume > 0 then
    return icons.volume._10
  end
  return icons.volume._0
end

local function animate_slider_width(width)
  sbar.animate("tanh", 30, function()
    volume_slider:set({ slider = { width = width } })
  end)
end

-- Hardware volume change: update glyph + percentage, reveal slider for 2s
volume_slider:subscribe("volume_change", function(env)
  local volume = tonumber(env.INFO)
  volume_icon:set({ label = icon_for(volume) })
  volume_slider:set({ slider = { percentage = volume } })
  animate_slider_width(100)

  sbar.exec("sleep 2", function()
    -- Only retract if the volume was not changed again in the meantime
    if tonumber(volume_slider:query().slider.percentage) == volume then
      animate_slider_width(0)
    end
  end)
end)

volume_slider:subscribe("mouse.clicked", function(env)
  sbar.exec("osascript -e 'set volume output volume " .. env.PERCENTAGE .. "'")
end)

volume_slider:subscribe("mouse.entered", function(_)
  volume_slider:set({ slider = { knob = { drawing = true } } })
end)

volume_slider:subscribe("mouse.exited", function(_)
  volume_slider:set({ slider = { knob = { drawing = false } } })
end)

-- Left click toggles the slider; right click / shift+click shows output devices
local function toggle_detail()
  if tonumber(volume_slider:query().slider.width) > 0 then
    animate_slider_width(0)
  else
    animate_slider_width(100)
  end
end

local function toggle_devices()
  sbar.exec("command -v SwitchAudioSource >/dev/null && echo yes || echo no", function(available)
    if available:find("yes") == nil then return end
    sbar.exec("SwitchAudioSource -t output -c", function(current)
      current = current:gsub("%s+$", "")
      sbar.exec("SwitchAudioSource -a -t output", function(list)
        local cmd = "sketchybar --remove '/volume.device\\.*/'"
          .. " --set volume_icon popup.drawing=toggle"
        local counter = 0
        for device in list:gmatch("[^\n]+") do
          local color = (device == current) and hex(colors.white) or hex(colors.grey)
          local click = "SwitchAudioSource -s \\\"" .. device .. "\\\""
            .. " && sketchybar --set '/volume.device\\.*/' label.color=" .. hex(colors.grey)
            .. " --set volume.device." .. counter .. " label.color=" .. hex(colors.white)
            .. " --set volume_icon popup.drawing=off"
          cmd = cmd
            .. " --add item volume.device." .. counter .. " popup.volume_icon"
            .. " --set volume.device." .. counter
            .. " label=\"" .. device .. "\""
            .. " label.color=" .. color
            .. " click_script=\"" .. click .. "\""
          counter = counter + 1
        end
        sbar.exec(cmd)
      end)
    end)
  end)
end

volume_icon:subscribe("mouse.clicked", function(env)
  if env.BUTTON == "right" or env.MODIFIER == "shift" then
    toggle_devices()
  else
    toggle_detail()
  end
end)
