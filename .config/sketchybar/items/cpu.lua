local colors = require("colors")
local settings = require("settings")

-- The compiled C mach helper (helper/) pushes data to cpu.sys / cpu.user and
-- sets the cpu.percent + cpu.top labels. These items only define the layout;
-- cpu.percent is wired to the helper via mach_helper.

sbar.add("item", "cpu.top", {
  position = "right",
  icon = { drawing = false },
  label = {
    string = "CPU",
    font = {
      family = settings.font,
      style = "Semibold",
      size = 10.0,
    },
  },
  width = 0,
  padding_right = 15,
  y_offset = 6,
})

sbar.add("item", "cpu.percent", {
  position = "right",
  icon = { drawing = false },
  label = {
    string = "CPU",
    font = {
      family = settings.font,
      style = "Heavy",
      size = 12.0,
    },
  },
  y_offset = -4,
  padding_right = 15,
  width = 55,
  update_freq = 2,
  mach_helper = settings.helper,
})

sbar.add("graph", "cpu.sys", 75, {
  position = "right",
  width = 0,
  graph = {
    color = colors.red,
    fill_color = colors.red,
  },
  label = { drawing = false },
  icon = { drawing = false },
  background = {
    height = 30,
    drawing = true,
    color = colors.transparent,
  },
})

sbar.add("graph", "cpu.user", 75, {
  position = "right",
  graph = {
    color = colors.blue,
  },
  label = { drawing = false },
  icon = { drawing = false },
  background = {
    height = 30,
    drawing = true,
    color = colors.transparent,
  },
})
