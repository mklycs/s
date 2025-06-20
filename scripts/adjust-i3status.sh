#!/bin/bash

set -e

# this will write an adjusted i3status-config file to: ~/.config/i3status/config
cat <<EOF > ~/.config/i3status/config
general {
    colors = true
    color_good = "#1E81B0"
    interval = 5
}

order += "wireless _first_"
order += "cpu_usage"
order += "volume master"
order += "tztime local"

wireless _first_ {
    format_up = "W: connected (%quality)"
    format_down = "W: not connected"
}

cpu_usage {
    format = "cpu usage: %usage"
}

volume master {
    format = "sound: %volume"
    format_muted = "sound: muted"
}

tztime local {
    format = "%H:%M:%S %d.%m.%Y"
}

EOF