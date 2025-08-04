#!/bin/bash

set -e

mkdir -p ~/.config/sway/scripts
touch ~/.config/sway/scripts/enable-automute-mode.sh
cat << 'EOF' > ~/.config/sway/scripts/enable-automute-mode.sh
#!/bin/bash

INTERVAL=5
TARGET_STATE="Enabled"
TARGET_CODEC="ALC256"

check_and_fix_auto_mute(){
    for card_dir in /proc/asound/card*/; do
        card_num=$(basename "$card_dir" | sed 's/card//')
        codec_file="${card_dir}/codec#0"

        if grep -q "$TARGET_CODEC" "$codec_file" 2>/dev/null; then
            # check if headphones are plugged in
            if amixer -c "$card_num" contents | grep -A3 'Jack' | grep -q 'values=on'; then
                # check Auto-Mute Mode
                current_state=$(amixer -c "$card_num" cget name='Auto-Mute Mode' 2>/dev/null >
                
                if [ "$current_state" != "$TARGET_STATE" ]; then
                    echo "Fixing Auto-Mute Mode..."
                    amixer -c "$card_num" cset name='Auto-Mute Mode' "$TARGET_STATE"
                fi
            fi
        fi
    done
}

while true; do
    check_and_fix_auto_mute
    sleep "$INTERVAL"
done
EOF

chmod +x ~/.config/sway/scripts/enable-automute-mode.sh
echo "exec_always ~/.config/sway/scripts/enable-automute-mode.sh" >> ~/.config/sway/config
