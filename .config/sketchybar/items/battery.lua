local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local battery = sbar.add("item", "battery", {
  position = "right",
  icon = {
    font = {
      family = settings.font,
      style = "Regular",
      size = 19.0,
    },
  },
  padding_left = 0,
  padding_right = 5,
  label = { drawing = false },
  update_freq = 120,
})

local function battery_update()
  sbar.exec("pmset -g batt", function(batt_info)
    local charging = batt_info:find("AC Power") ~= nil
    local _, _, charge = batt_info:find("(%d+)%%")
    charge = tonumber(charge)

    local icon = icons.battery._0
    local color = colors.white

    if charge then
      if charge >= 90 then
        icon = icons.battery._100
      elseif charge >= 60 then
        icon = icons.battery._75
      elseif charge >= 30 then
        icon = icons.battery._50
      elseif charge >= 10 then
        icon = icons.battery._25
        color = colors.orange
      else
        icon = icons.battery._0
        color = colors.red
      end
    end

    if charging then
      icon = icons.battery.charging
    end

    battery:set({ icon = { string = icon, color = color } })
  end)
end

battery:subscribe({ "routine", "forced", "power_source_change", "system_woke" }, battery_update)
