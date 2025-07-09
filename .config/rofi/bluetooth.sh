#!/bin/bash

choice=$(echo -e "List Devices\nConnect\nDisconnect\nToggle Power" | rofi -dmenu -i -p "Bluetooth Options")

case "$choice" in
    "List Devices")
        bluetoothctl devices | rofi -dmenu -i -p "Paired Devices"
        ;;
    "Connect")
        devices=$(bluetoothctl devices | awk '{print substr($0, index($0,$2))}')
        device=$(echo "$devices" | rofi -dmenu -i -p "Connect to Device" | awk '{print $1}')
        [ -n "$device" ] && bluetoothctl connect "$device"
        ;;
    "Disconnect")
        devices=$(bluetoothctl paired-devices | awk '{print substr($0, index($0,$2))}')
        device=$(echo "$devices" | rofi -dmenu -i -p "Disconnect Device" | awk '{print $1}')
        [ -n "$device" ] && bluetoothctl disconnect "$device"
        ;;
    "Toggle Power")
        power_state=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
        if [ "$power_state" == "yes" ]; then
            bluetoothctl power off
        else
            bluetoothctl power on
        fi
        ;;
    *)
        exit 0
        ;;
esac
