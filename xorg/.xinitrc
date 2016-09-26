#!/usr/bin/env zsh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*; do
    [ -x "$f" ] && source "$f"
  done
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I"$HOME" ~/.Xresources

feh --bg-scale ~/Pictures/wallpapers/city-1.jpg &
xsetroot -cursor_name left_ptr &
urxvtd &
sxhkd &
dunst &

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

eval $(keychain --eval --quiet)

xrandr --output DP-0 --primary --mode 3840x2160 --rate 60 --dpi 138
compton &

exec bspwm

