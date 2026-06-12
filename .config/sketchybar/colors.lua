-- Rose Pine Color Palette (Official)
return {
  black = 0xff191724,   -- base
  white = 0xffe0def4,   -- text
  red = 0xffeb6f92,     -- love
  green = 0xff31748f,   -- pine
  blue = 0xff9ccfd8,    -- foam
  yellow = 0xfff6c177,  -- gold
  orange = 0xffebbcba,  -- rose
  magenta = 0xffc4a7e7, -- iris
  grey = 0xff6e6a86,    -- muted
  subtle = 0xff908caa,  -- subtle
  overlay = 0xff26233a, -- overlay
  transparent = 0x00000000,

  -- General bar colors
  bar = {
    bg = 0xff1f1d2e,     -- surface
    border = 0xff403d52, -- highlight med
  },

  popup = {
    bg = 0xff26233a,     -- overlay
    border = 0xff908caa, -- subtle
  },

  -- overlay / highlight_med with transparency
  bg1 = 0x9026233a,
  bg2 = 0x90403d52,

  shadow = 0xff191724,

  -- Helper to add transparency to a color
  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
