#!/bin/bash

LC_ALL=en_US.UTF-8

ethernet_interface="enp4s0f3u1u1c2"
wifi_interface="wlo1"

ethernet_connected=$(nmcli -t -f DEVICE,STATE device status | grep "^$ethernet_interface:" | cut -d: -f2)
wifi_connected=$(nmcli -t -f DEVICE,STATE device status | grep "^$wifi_interface:" | cut -d: -f2)

get_wifi_icon() {
  local signal=$1
  if [ "$signal" -ge 75 ]; then
    echo "󰤨" # Full signal
  elif [ "$signal" -ge 50 ]; then
    echo "󰤥" # High signal
  elif [ "$signal" -ge 25 ]; then
    echo "󰤢" # Medium signal
  else
    echo "󰤟" # Low signal
  fi
}

if [ "$ethernet_connected" == "connected" ]; then
  ip=$(nmcli -g IP4.ADDRESS dev show $ethernet_interface | head -n 1)
  echo "{\"text\": \"󰈀\", \"tooltip\": \"$ip\"}"
elif [ "$wifi_connected" == "connected" ]; then
  essid=$(nmcli -g GENERAL.CONNECTION dev show $wifi_interface)
  signal=$(awk 'NR==3 {printf "%d", $3 * 100 / 70}' /proc/net/wireless)
  icon=$(get_wifi_icon $signal)
  echo "{\"text\": \"$icon\", \"tooltip\": \"$essid ($signal%)\"}"
else
  echo "{\"text\": \"󰤮\", \"tooltip\": \"No connection\"}"
fi

