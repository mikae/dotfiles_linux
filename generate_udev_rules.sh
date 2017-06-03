#!/usr/bin/env bash

echo_green 'Updating udev rules'

CURRENT_USERNAME=$USER
SETFACL_LOCATION=`whereis setfacl | awk '{print $2}'`
HDPARM_LOCATION=`whereis hdparm | awk '{print $2}'`

echo_green 'Generating hdparm rule'
sudo su -c "cat > /etc/udev/rules.d/50-hdparm.rules << EOF
ACTION==\"add\", SUBSYSTEM==\"block\", KERNEL==\"sda\", RUN+=\"$HDPARM_LOCATION -B 255 -S 0 /dev/sda\"
EOF"

echo_green 'Generating uinput rule'
sudo su -c 'cat > /etc/udev/rules.d/40-uinput.rules << EOF
SUBSYSTEM=="misc", KERNEL=="uinput", MODE="0660", GROUP="uinput"
EOF'

echo_green 'Updating udev rules'
sudo su -c "cat > /etc/udev/rules.d/99-userdev-input.rules << EOF
KERNEL==\"event*\", SUBSYSTEM==\"input\", RUN+=\"$SETFACL_LOCATION -m u:$CURRENT_USERNAME:rw \\\$env{DEVNAME}\"
EOF"

echo_green 'udev rules are updated'
