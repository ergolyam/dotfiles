#!/bin/bash

if nmcli device status | grep -q "eth0.*connected"; then
  if nmcli device disconnect enp4s0f3u1u1c2; then
    notify-send "Ethernet off."
  else
    notify-send "Failed to disable Ethernet."
  fi
else
  if nmcli device connect enp4s0f3u1u1c2; then
    notify-send "Ethernet on."
  else
    notify-send "Failed to enable Ethernet."
  fi
fi
