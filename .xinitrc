# enable fcitx
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# key mapping
xmodmap ~/.Xmodmap

# cursor speed more faster
# check your device `xinput list`
xinput --set-prop 'TPPS/2 Elan TrackPoint' 'libinput Accel Speed' 0.7
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Accel Speed' 0.7
xinput --set-prop 'SynPS/2 Synaptics TouchPad' 'Device Enabled' 0
