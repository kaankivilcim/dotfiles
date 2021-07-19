#!/bin/bash

/usr/bin/scrot ~/.config/i3/locked.png

/usr/bin/convert ~/.config/i3/locked.png -scale 10% -scale 1000% ~/.config/i3/locked.png
/usr/bin/convert ~/.config/i3/locked.png -gravity center -composite -matte ~/.config/i3/locked.png

/usr/bin/i3lock -n -u -c 282828 -i ~/.config/i3/locked.png
