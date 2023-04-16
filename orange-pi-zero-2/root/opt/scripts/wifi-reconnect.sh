#!/bin/bash
# For whatever reason, at random points in time, the pi disconnects from wifi and never
# seems to reconnect. So this script (added as a cron for root) aims to detect it and
# restart the radio
# * * * * * /bin/bash /opt/scripts/wifi-reconnect.sh
numConnections=$(/usr/bin/nmcli con show --active | grep wifi | wc -l)

if [ $numConnections == 0 ]
then
	echo "Wifi not connected, trying to restart" | tee >(logger -t 'wifi-cron')
    # /usr/bin/nmcli radio wifi off # might not be necessary
    # sleep 1s
    # /usr/bin/nmcli radio wifi on
    /usr/bin/nmcli device connect wlan0
else
	echo "Wifi still connected" | tee >(logger -t 'wifi-cron')
fi
