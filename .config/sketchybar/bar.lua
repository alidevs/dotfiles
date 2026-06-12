local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  height = 40,
  color = colors.with_alpha(colors.bar.bg, 0.94),
  shadow = false,
  position = "top",
  sticky = true,
  padding_right = 10,
  padding_left = 10,
  corner_radius = 0,
  y_offset = 0,
  margin = 0,
  blur_radius = 40,
  notch_width = 0,
})
