#!/usr/bin/env bash

# # Take a screenshot and save it
# scrot /tmp/screen_locked.png

# # Blur the screenshot using ImageMagick
# convert /tmp/screen_locked.png -filter Gaussian -blur 0x8 /tmp/screen_locked_blurred.png

# # Lock the screen using the blurred image
# i3lock -i /tmp/screen_locked_blurred.png

# # (Optional) Remove the blurred image after use
# rm /tmp/screen_locked_blurred.png

# Get exact screen resolution
SCREEN_RES=$(xrandr | grep '*' | awk '{print $1}')

# Resize to exact screen dimensions without preserving aspect ratio
convert "$HOME/Pictures/wallpapers/wallhaven-q2yv1l.jpg" -resize ${SCREEN_RES}\! PNG8:/tmp/lock.png

i3lock -i /tmp/lock.png