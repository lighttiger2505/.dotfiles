#!/bin/bash

wallpapers=~/.config/wallpapers

while true; do
    feh --randomize --bg-fill ${wallpapers}
    sleep 60m
done
