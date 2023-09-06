#!/bin/bash

IMAGE=/tmp/i3lock.png

# Take a screenshot
grim -o $(swaymsg -t get_outputs | jq -r '.[] .name') $IMAGE

# Pixellate it 10x
convert $IMAGE -scale 10% -scale 1000% -fill black -colorize 45% $IMAGE

# Lock screen displaying this image.
swaylock -i $IMAGE
