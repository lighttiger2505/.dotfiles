#!/usr/bin/bash

capacity=$(cat /sys/class/power_supply/"$1"/capacity) || exit
status=$(cat /sys/class/power_supply/"$1"/status)
echo "${status} ${capacity}%"
