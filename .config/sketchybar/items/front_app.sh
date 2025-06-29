#!/bin/bash

FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO" icon="$($HOME/.config/sketchybar/plugins/icon_map.sh "$INFO")"'

yabai=(
  script="$PLUGIN_DIR/yabai.sh"
  icon.drawing=off
  label.drawing=off
  associated_display=active
)

front_app=(
  script="$FRONT_APP_SCRIPT"
  icon.drawing=on
  icon.font="sketchybar-app-font:Regular:16.0"
  icon.color=$ORANGE
  padding_left=0
  label.color=$WHITE
  label.font="$FONT:Black:12.0"
  associated_display=active
)

sketchybar --add event window_focus            \
           --add event windows_on_spaces       \
           --add item yabai left               \
           --set yabai "${yabai[@]}"           \
           --subscribe yabai window_focus      \
                             windows_on_spaces \
                             mouse.clicked     \
                                               \
           --add item front_app left           \
           --set front_app "${front_app[@]}"   \
           --subscribe front_app front_app_switched

