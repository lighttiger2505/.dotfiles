#!/usr/bin/bash -x

# SSID
SSID_NAME=$(iwgetid -r)

# Network Quality

if [[ -z "$INTERFACE" ]] ; then
    INTERFACE="${BLOCK_INSTANCE:-wlp2s0}"
fi

[[ ! -d /sys/class/net/${INTERFACE}/wireless ]] && exit

if [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
    echo "down"
    echo "down"
    echo "#FF0000"
    exit
fi

QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

echo "${SSID_NAME} ${QUALITY}%"
