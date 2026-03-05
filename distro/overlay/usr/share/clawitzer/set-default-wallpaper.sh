#!/bin/sh
# Set Clawitzer wallpaper as default (run once, e.g. from first-run or install).
WALLPAPER="/usr/share/clawitzer/wallpaper.svg"
if [ -f "$WALLPAPER" ]; then
  for user in /home/*; do
    [ -d "$user" ] || continue
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u "$(basename "$user")" 2>/dev/null)/bus"
    gsettings set org.cinnamon.desktop.background picture-uri "file://$WALLPAPER" 2>/dev/null || true
  done
  # Default for new users (skeleton)
  mkdir -p /etc/skel/.config
  [ -f /etc/skel/.config/dconf/user ] || true
fi
