#!/bin/bash

set -e

mkdir -p ~/.config/waybar
touch ~/.config/waybar/config

cat << 'EOF' > ~/.config/waybar/config
{
  "layer": "top",
  "position": "bottom",
  "modules-left": ["sway/workspaces"],
  "modules-right": ["cpu", "network", "pulseaudio","backlight", "battery", "clock", "custom/power"],

  "cpu": {
    "format": "cpu: {usage}% | ",
    "interval" : 2
  },
  "network": {
    "format-wifi": "connected: {signalStrength}%",
    "format-ethernet": "connected: ethernet",
    "format-disconnected": "disconnected"
  },
  "pulseaudio": {
    "format": " | volume: {volume}% | ",
    "format-muted": " | volume: muted | "
  },
  "backlight": {
    "format": "light: {percent}% | ",
    "device": "amdgpu_bl0"
  },
  "battery": {
    "format": "power: {capacity}%",
    "states": {
      "critical": 15,
      "low": 30
    }
  },
  "clock": {
    "format": " | {:%H:%M} | ",
    "tooltip-format": "{:%A, %d. %B %Y}",
    "name": "clock"
  },
  "custom/power": {
    "name": "home-button",
    "format": "⏻",
    "tooltip": false,
    "on-click": "exec ~/.local/bin/powermenu"
  }
}
EOF

touch ~/.config/waybar/style.css
cat << 'EOF' > ~/.config/waybar/style.css
* {
  font-family: "BigBlueTermPlus Nerd Font Mono", monospace;
  font-size: 15px;
  background-color: #000000;
  color: #ffffff;
  border-radius: 0px;
}

#workspaces {
  margin: 0 0;
}

#workspaces button {
  padding: 2px;
  margin: 0px;
  border: 1px solid transparent;
  border-radius: 0;
  background-color: transparent;
  color: #ffffff;
}

#workspaces button label{
  background-color: #000000;
}

#workspaces button.active {
  border-top: 2px solid #000000;
  border-bottom: 2px solid #285577;
}

#workspaces button.active label {
  color: #285577;
}

#workspaces button.inactive label {
  color: #444444;
}

#workspaces button.focused {
  border-top: 2px solid #000000;
  border-bottom: 2px solid #285577;
}

#workspaces button.visible {
  background-color: #000000;
}

#workspaces button.urgent {
  border-top: 2px solid #000000;
  border-bottom: 2px solid #900000;
}

#network.wifi, #network.ethernet {
  color: limegreen;
}

#network.disconnected {
  color: red;
}

#battery {
  color: #FFFFFF;
}

#battery.low {
  color: yellow;
}

#battery.critical {
  color: red;
}

#battery.charging {
  color: limegreen;
}

#custom-power { /* home-button */
  margin-right: 12px;
  color: #3D6BB3;
}
EOF
