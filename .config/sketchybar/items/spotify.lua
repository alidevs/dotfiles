local colors = require("colors")
local settings = require("settings")

local plugin_dir = os.getenv("HOME") .. "/.config/sketchybar/plugins"
local script = plugin_dir .. "/spotify.sh"
local toggle = "sketchybar -m --set spotify.anchor popup.drawing=toggle"

-- Distributed notification fired by Spotify on playback state changes
sbar.add("event", "spotify_change", "com.spotify.client.PlaybackStateChanged")

-- Anchor lives in the center of the bar; the rest of the UI is in its popup
local anchor = sbar.add("item", "spotify.anchor", {
  position = "center",
  script = script,
  click_script = toggle,
  popup = {
    horizontal = true,
    align = "center",
    height = 150,
  },
  icon = {
    string = "􁁒",
    font = {
      family = settings.font,
      style = "Regular",
      size = 25.0,
    },
  },
  label = { drawing = false },
  drawing = false,
  y_offset = 2,
})
anchor:subscribe({ "mouse.entered", "mouse.exited", "mouse.exited.global" })

local cover = sbar.add("item", "spotify.cover", {
  position = "popup.spotify.anchor",
  script = script,
  click_script = "open -a 'Spotify'; " .. toggle,
  label = { drawing = false },
  icon = { drawing = false },
  padding_left = 12,
  padding_right = 10,
  background = {
    image = {
      scale = 0.2,
      drawing = true,
    },
    drawing = true,
  },
})

sbar.add("item", "spotify.title", {
  position = "popup.spotify.anchor",
  icon = { drawing = false },
  padding_left = 0,
  padding_right = 0,
  width = 0,
  label = {
    font = {
      family = settings.font,
      style = "Heavy",
      size = 15.0,
    },
  },
  y_offset = 55,
})

sbar.add("item", "spotify.artist", {
  position = "popup.spotify.anchor",
  icon = { drawing = false },
  y_offset = 30,
  padding_left = 0,
  padding_right = 0,
  width = 0,
})

sbar.add("item", "spotify.album", {
  position = "popup.spotify.anchor",
  icon = { drawing = false },
  y_offset = 15,
  padding_left = 0,
  padding_right = 0,
  width = 0,
})

local state = sbar.add("slider", "spotify.state", 115, {
  position = "popup.spotify.anchor",
  script = script,
  update_freq = 1,
  updates = "when_shown",
  icon = {
    drawing = true,
    string = "00:00",
    width = 35,
    font = {
      family = settings.font,
      style = "Light Italic",
      size = 10.0,
    },
  },
  label = {
    drawing = true,
    string = "00:00",
    width = 35,
    font = {
      family = settings.font,
      style = "Light Italic",
      size = 10.0,
    },
  },
  padding_left = 0,
  padding_right = 0,
  y_offset = -15,
  width = 0,
  slider = {
    background = {
      height = 6,
      corner_radius = 1,
      color = colors.grey,
    },
    highlight_color = colors.green,
    percentage = 40,
  },
})
state:subscribe("mouse.clicked")

local shuffle = sbar.add("item", "spotify.shuffle", {
  position = "popup.spotify.anchor",
  script = script,
  icon = {
    string = "􀊝",
    padding_left = 5,
    padding_right = 5,
    color = colors.black,
    highlight_color = colors.grey,
  },
  label = { drawing = false },
  y_offset = -45,
})
shuffle:subscribe("mouse.clicked")

local back = sbar.add("item", "spotify.back", {
  position = "popup.spotify.anchor",
  script = script,
  icon = {
    string = "􀊎",
    padding_left = 5,
    padding_right = 5,
    color = colors.black,
  },
  label = { drawing = false },
  y_offset = -45,
})
back:subscribe("mouse.clicked")

local play = sbar.add("item", "spotify.play", {
  position = "popup.spotify.anchor",
  script = script,
  icon = {
    string = "􀊔",
    padding_left = 4,
    padding_right = 5,
    color = colors.white,
  },
  background = {
    height = 40,
    corner_radius = 20,
    color = colors.popup.bg,
    border_color = colors.white,
    border_width = 0,
    drawing = true,
  },
  width = 40,
  align = "center",
  updates = true,
  label = { drawing = false },
  y_offset = -45,
})
play:subscribe({ "mouse.clicked", "spotify_change" })

local next_track = sbar.add("item", "spotify.next", {
  position = "popup.spotify.anchor",
  script = script,
  icon = {
    string = "􀊐",
    padding_left = 5,
    padding_right = 5,
    color = colors.black,
  },
  label = { drawing = false },
  y_offset = -45,
})
next_track:subscribe("mouse.clicked")

local repeat_ = sbar.add("item", "spotify.repeat", {
  position = "popup.spotify.anchor",
  script = script,
  icon = {
    string = "􀊞",
    padding_left = 5,
    padding_right = 10,
    color = colors.black,
    highlight_color = colors.grey,
  },
  label = { drawing = false },
  y_offset = -45,
})
repeat_:subscribe("mouse.clicked")

sbar.add("item", "spotify.spacer", {
  position = "popup.spotify.anchor",
  width = 5,
})

sbar.add("bracket", "spotify.controls", {
  "spotify.shuffle",
  "spotify.back",
  "spotify.play",
  "spotify.next",
  "spotify.repeat",
}, {
  background = {
    color = colors.green,
    corner_radius = 11,
    drawing = true,
  },
  y_offset = -45,
})
