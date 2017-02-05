#!/usr/bin/env zsh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*; do
    [ -x "$f" ] && source "$f"
  done
fi

[[ -f ~/.Xresources ]] && xrdb -merge -I"$HOME" ~/.Xresources

for control in Headphones PCM Front Surround Center LFE Line; do
  amixer sset "$control" 0dB unmute &
done

amixer sset Master 25% unmute &
pulseaudio --start &

feh --bg-scale ~/.config/wallpapers/current &
xsetroot -cursor_name left_ptr &
urxvtd &
sxhkd &
dunst &

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

xrandr --output DP-0 --primary --mode 3840x2160 --rate 60 --dpi 138
compton &

exec bspwm

