#!/bin/bash
# get the touchpad ID
# put your device name below. Should be sufficient just to grep for Touchpad with xinput and paste the device name.
ID=$(xinput list --id-only "ELAN1200:00 04F3:30BA Touchpad")
# get the status
STATUS=$(xinput list-props $ID | grep "Device Enabled"|awk '{print $4}')
# get the tap status and property ID
TEMP=$(xinput list-props $ID | grep --max-count=1  "Tapping Enabled")
TAP=$(echo $TEMP|awk '{print $5}')
PROP=$(echo $TEMP|awk '{print $4}'|cut -b 2-4)

case $1 in
    devonoff)
        if [ $STATUS -ne 0 ]
        then
          xinput --disable $ID 
          notify-send -u low -i input-touchpad "Touchpad disabled"
        else
          xinput --enable $ID
          notify-send -u low -i input-touchpad "Touchpad enabled"
        fi
    ;;
    taponoff)
        if [ $TAP -ne 0 ]
        then
            xinput --set-prop $ID $PROP 0
            notify-send -u low -i input-touchpad "Tapping disabled"
        else
            xinput --set-prop $ID $PROP 1
            notify-send -u low -i input-touchpad "Tapping enabled"
        fi
    ;;
esac
