#!/bin/bash

set -e

mkdir -p ~/.local/bin

cat << 'EOF' > ~/.local/bin/wofi-launcher
#!/bin/sh
export GTK_THEME=Adwaita-dark
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export GDK_BACKEND=wayland,x11

wofi --show drun

EOF

chmod +x ~/.local/bin/wofi-launcher

mkdir -p ~/.config/wofi
touch ~/.config/wofi/style.css

cat << 'EOF' > ~/.config/wofi/style.css
window {
  font-family: "BigBlueTermPlus Nerd Font Mono", monospace;
  font-size: 15px;
  background-color: #000000;
  color: #ffffff;
  border: 2px solid #285577;
}

#entry {
  padding: 10px;
  background-color: #000000;
  color: #ffffff;
}

#entry:selected {
  background-color: #285577;
  color: #ffffff;
}

#input {
  padding: 3px 10px;
  margin: 3px; 
  background-color: #111111;
  color: #ffffff;
  border: none;
  border-radius: 0;
}

#inner-box {
  padding: 2px;
}

#outer-box {
  padding: 8px;
}
EOF
