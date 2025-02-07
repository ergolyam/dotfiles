#!/bin/bash

LC_ALL=en_US.UTF-8

ethernet_interface="enp2s0f0"
wifi_interface="wlp3s0"

ethernet_connected=$(nmcli -t -f DEVICE,STATE device status | grep "^$ethernet_interface:" | cut -d: -f2)
wifi_connected=$(nmcli -t -f DEVICE,STATE device status | grep "^$wifi_interface:" | cut -d: -f2)

get_wifi_icon() {
  local signal=$1
  if [ "$signal" -ge -50 ]; then
    echo "󰤨 " # Full signal
  elif [ "$signal" -ge -70 ]; then
    echo "󰤥 " # High signal
  elif [ "$signal" -ge -85 ]; then
    echo "󰤢 " # Medium signal
  else
    echo "󰤟 " # Low signal
  fi
}

if [ "$wifi_connected" == "connected" ]; then
  essid=$(nmcli -g GENERAL.CONNECTION dev show $wifi_interface)
  signal=$(iw dev $wifi_interface link | grep 'signal' | awk '{print $2}')
  icon=$(get_wifi_icon $signal)
  echo "{\"text\": \"$icon\", \"tooltip\": \"$essid ($signal dBm)\"}"
elif [ "$ethernet_connected" == "connected" ]; then
  ip=$(nmcli -g IP4.ADDRESS dev show $ethernet_interface | head -n 1)
  echo "{\"text\": \"󰈀 \", \"tooltip\": \"$ip\"}"
else
  echo "{\"text\": \"󰤮 \", \"tooltip\": \"No connection\"}"
fi

