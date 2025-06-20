#!/bin/bash

set -e

chmod +x ./scripts/make-scripts-executable.sh
./scripts/make-scripts-executable.sh

# execute configuration scripts
./scripts/install-packages.sh
./scripts/configure-wofi.sh
./scripts/configure-powermenu.sh
./scripts/configure-sway.sh
./scripts/adjust-i3status.sh
./scripts/adjust-bash.sh
./scripts/adjust-profile.sh
./scripts/adjust-terminal.sh
./scripts/remove-packages.sh

# reboot system
sudo reboot -h now

