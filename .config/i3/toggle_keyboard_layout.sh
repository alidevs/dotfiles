#!/bin/bash

# Get the current layout
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')
current_variant=$(setxkbmap -query | grep variant | awk '{print $2}')

# Check the current layout and toggle to the other layout
if [ "$current_layout" = "us" ]; then
    setxkbmap -layout ara -variant mac
else
    setxkbmap -layout us
fi
