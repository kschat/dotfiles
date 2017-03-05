#!/usr/bin/env zsh

bg='/tmp/screen.png'

cleanup() {
  [ -f "$bg" ] && rm -f "$bg"
}

trap cleanup SIGHUP SIGINT SIGTERM

scrot "$bg"
convert "$bg" -scale 10% -scale 1000% "$bg"

i3lock -ui "$bg"
cleanup

