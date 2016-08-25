!/usr/bin/env bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*; do
    [ -x "$f" ] && . "$f"
  done
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

xrandr --output VGA-1 --mode 2560x1600

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

exec i3

