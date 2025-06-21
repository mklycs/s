#!/bin/bash

set -e

cat <<'EOF' > ~/.local/bin/powermenu
#!/bin/bash

CHOICE=$(printf "Power Off \nReboot \nSuspend \nLock \nLogout" | GTK_THEME=Adwaita-dark wofi --dmenu --insensitive)

case "$CHOICE" in
    *Power*) systemctl poweroff ;;
    *Reboot*) systemctl reboot ;;
    *Suspend*) systemctl suspend && swaylock -c 000000 ;;
    *Lock*) swaylock -c 000000 ;;
    *Logout*) swaymsg exit ;;
esac

EOF

chmod +x ~/.local/bin/powermenu