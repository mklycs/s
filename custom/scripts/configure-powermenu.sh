#!/bin/bash

set -e

cat << 'EOF' > ~/.local/bin/powermenu
#!/bin/bash

CHOICE=$(printf "Power Off \nReboot \nSuspend \nLock \nLogout" | GTK_THEME=Adwaita-dark wofi --dmenu --insensitive)

case "$CHOICE" in
    *Power*) systemctl poweroff ;;
    *Reboot*) systemctl reboot ;;
    *Suspend*) systemctl suspend && swaylock -c 111D33  \
                --inside-color 111D33 \
                --ring-color FFFFFF \
                --key-hl-color 00FF00 \
                --line-color 111D33 \
                --text-color FFFFFF \
                --separator-color FFFFFF \
                --inside-ver-color 111D33 \
                --ring-ver-color 111D33 \
                --line-ver-color 111D33 \
                --text-ver-color FFFF00 \
                --inside-wrong-color 330000 \
                --ring-wrong-color FF0000 \
                --line-wrong-color FF0000 \
                --text-wrong-color FF0000;;
    *Lock*) swaylock -c 111D33 \
                --inside-color 111D33 \
                --ring-color FFFFFF \
                --key-hl-color 00FF00 \
                --line-color 111D33 \
                --text-color FFFFFF \
                --separator-color FFFFFF \
                --inside-ver-color 111D33 \
                --ring-ver-color 111D33 \
                --line-ver-color 111D33 \
                --text-ver-color FFFF00 \
                --inside-wrong-color 330000 \
                --ring-wrong-color FF0000 \
                --line-wrong-color FF0000 \
                --text-wrong-color FF0000;;
    *Logout*) swaymsg exit ;;
esac
EOF

chmod +x ~/.local/bin/powermenu
