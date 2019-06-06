#!/bin/bash

display="HDMI1"
st_prev=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | grep ${display})

while :
do
    st_next=$(xrandr | grep " connected" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/" | grep ${display})
    if [ "${st_prev}" != "${st_next}" ]; then
        st_prev=$st_next
        if [ "${st_next}" = "${display}" ]; then
            xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output ${display} --mode 1920x1080 --pos 0x0 --rotate normal
        else
            xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output ${display} --off
        fi
    fi
    sleep 1
done
