#!/bin/bash

function timer_on() {
    let seconds=$1*60 # minutes -> seconds
    local last=`expr $(date +%s) + $seconds`
    echo -e "SWITCH: TIMER\nLAST: $last" > $TMPFILE
}

function timer_off() {
    init;
}

function init() { echo -e "SWITCH: DATE\nLAST:\n" > $TMPFILE; }

function get() { cat $TMPFILE | awk '/'$1'/ {print $2}'; } # $1: SWITCH or LAST

function countdown() {
    let diff=$(get "LAST")-$(date +%s)
    if [ $diff -lt 0 ]; then
        timer_off
        notify-send 'END OF TIMER' 'How are you doing ?'
        exit
    fi
    # let hour="$diff / 3600"
    # let diff="$diff % 3600"
    let minute="$diff / 60"
    let second="$diff % 60"
    printf " 🍅%02d:%02d | %s " $minute $second $dtstr
}

# temporary file
TMPFILE="/tmp/timerx_tmp"
! [ -e $TMPFILE ] && init

# check argument
# --------------
case "$1" in
    "-h")
        echo "usage: timerx [minutes|--off]" 1>&2
        exit
        ;;
    "--off")
        timer_off
        exit
        ;;
    -*|--*)
        echo "$1: unknown option" 1>&2
        exit 1
        ;;
esac

expr "$1" + 1 >/dev/null 2>&1 # check if $1 is numeric or not
if [ $? -lt 2 ]; then
    timer_on $1
    exit
fi

# check switch
dtstr="🕒$(date '+%H:%M')"
SWITCH=$(get "SWITCH")
if [ $SWITCH = "TIMER" ]; then
    countdown
else # elif [ $SWITCH = "DATE" ]; then
    printf " %s " $dtstr
fi
