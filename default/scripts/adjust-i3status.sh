#!/bin/bash

set -e

# this will write an adjusted i3status-config file to: ~/.config/i3status/config
cat <<EOF > ~/.config/i3status/config
general {
    colors = true
    color_good = "#1E81B0"
    interval = 5
}

order += "cpu_usage"
order += "wireless _first_"
order += "volume master"
order += "battery BAT0"
order += "tztime local"

cpu_usage {
    format = "cpu usage: %usage"
}

wireless _first_ {
    format_up = "W: connected (%quality)"
    format_down = "W: not connected"
}

volume master {
    format = "sound: %volume"
    format_muted = "sound: muted"
}

battery BAT0{
    format = "power: %status %percentage"
    path = "/sys/class/power_supply/BAT0"
    low_threshold = 30
    threshold_type = "percentage"
    format_down = "power: unknown"
}

tztime local {
    format = "%H:%M:%S %d.%m.%Y"
}

EOF
