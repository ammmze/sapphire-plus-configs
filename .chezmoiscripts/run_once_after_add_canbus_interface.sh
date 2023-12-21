#!/usr/bin/env bash

cat <<'EOF' | sudo tee /etc/network/interfaces.d/can0 > /dev/null
allow-hotplug can0
iface can0 can static
 bitrate 500000
 up ifconfig $IFACE txqueuelen 128
 #pre-up ip link set can0 type can bitrate 500000
 #pre-up ip link set can0 txqueuelen 128
EOF

# then need to reboot...though maybe just restarting network service would pick it up? or `sudo ifdown can0 ; sudo ifup can0`?
