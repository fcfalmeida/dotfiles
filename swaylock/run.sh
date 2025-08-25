#!/bin/bash

# Kanagawa Dragon / OldWhite Palette
COLOR_BASE="#1F1F28"       # sumiInk0 (background)
COLOR_BEIGE="#DCD7BA"      # oldWhite (main beige tone)
COLOR_RING="#CFC8A6"       # beige ring for unfocused state
COLOR_TEXT="#DCD7BA"       # oldWhite for text/clock
COLOR_WRONG="#C34043"      # autumnRed (wrong password)
COLOR_VERIFY="#7E9CD8"     # springBlue (verifying password)
COLOR_CAPSLOCK="#BFB896"   # muted beige for Caps Lock
COLOR_TRANSPARENT="#00000000" # fully transparent

swaylock \
  --ignore-empty-password \
  --screenshots \
  --effect-blur 7x5 \
  --effect-vignette 0.5:0.5 \
  --fade-in 0.5 \
  --indicator \
  --indicator-radius 100 \
  --indicator-thickness 5 \
  --inside-color $COLOR_TRANSPARENT \
  --inside-wrong-color $COLOR_TRANSPARENT \
  --inside-ver-color $COLOR_TRANSPARENT \
  --inside-clear-color $COLOR_TRANSPARENT \
  --inside-caps-lock-color $COLOR_TRANSPARENT \
  --ring-color $COLOR_RING \
  --ring-wrong-color $COLOR_WRONG \
  --ring-ver-color $COLOR_VERIFY \
  --ring-clear-color $COLOR_BEIGE \
  --ring-caps-lock-color $COLOR_CAPSLOCK \
  --line-color $COLOR_TRANSPARENT \
  --line-wrong-color $COLOR_WRONG \
  --line-ver-color $COLOR_VERIFY \
  --line-clear-color $COLOR_BEIGE \
  --line-caps-lock-color $COLOR_CAPSLOCK \
  --text-color $COLOR_TEXT \
  --text-wrong-color $COLOR_WRONG \
  --text-ver-color $COLOR_VERIFY \
  --text-clear-color $COLOR_BEIGE \
  --text-caps-lock-color $COLOR_CAPSLOCK \
  --key-hl-color $COLOR_BEIGE \
  --bs-hl-color $COLOR_RING \
  --hide-keyboard-layout \
  --disable-caps-lock-text \
  --no-unlock-indicator \
  --clock \
  --timestr "%H:%M:%S" \
  --datestr "%a, %d %b %Y"
