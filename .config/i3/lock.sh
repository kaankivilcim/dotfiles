#!/bin/bash

scrot ~/.config/i3/locked.png

convert ~/.config/i3/locked.png -scale 10% -scale 1000% ~/.config/i3/locked.png
convert ~/.config/i3/locked.png -gravity center -composite -matte ~/.config/i3/locked.png

i3lock -n -u -c 282828 -i ~/.config/i3/locked.png
