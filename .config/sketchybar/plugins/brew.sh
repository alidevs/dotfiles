#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

export PATH="/opt/homebrew/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_DOWNLOAD_CONCURRENCY=4

COUNT=$(brew outdated --quiet 2>/dev/null | grep -c '.')

COLOR=$RED

case "$COUNT" in
[3-5][0-9])
  COLOR=$ORANGE
  ;;
[1-2][0-9])
  COLOR=$YELLOW
  ;;
[1-9])
  COLOR=$WHITE
  ;;
0)
  COLOR=$GREEN
  COUNT=􀆅
  ;;
esac

sketchybar --set $NAME label=$COUNT icon.color=$COLOR
