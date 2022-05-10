#!/usr/bin/env zsh

window_manager=${1:-bspwm}

if [[ $window_manager != 'gnome' ]]; then
  if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*; do
      [ -x "$f" ] && source "$f"
    done
  fi

  [[ -f ~/.Xresources ]] && xrdb -merge -I"$HOME" ~/.Xresources

  for control in Headphones PCM Front Surround Center LFE Line; do
    amixer sset "$control" 0dB unmute &
  done

  amixer sset Master 20% unmute &
  pulseaudio --start

  [[ -f ~/Music/startup-sound.mp3 ]] && mpv --no-terminal ~/Music/startup-sound.mp3 &

  ~/.config/mopidy/start &

  urxvtd &

  # Maybe not needed for AwesomeWM?
  autocutsel -fork &

  xrandr --output DP-0 --primary --mode 3840x1600 --rate 144 --dpi 109
  nvidia-settings --load-config-only &
  picom &
  redshift -l 39.95:-75.17 &

  if [[ $window_manager == 'bspwm' ]]; then
    feh --bg-fill ~/.config/wallpapers/current &
    xsetroot -cursor_name left_ptr &
    sxhkd &
    dunst &
  fi
fi

if [[ $window_manager == 'gnome' ]]; then
  export XDG_SESSION_TYPE=x11
  export GDK_BACKEND=x11
fi

exec "$window_manager"
