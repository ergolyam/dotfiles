#!/bin/bash

if nmcli device status | grep -q "eth0.*connected"; then
  if nmcli device disconnect enp4s0f3u1u1c2; then
    notify-send "Ethernet выключен"
  else
    notify-send "Ошибка при выключении Ethernet"
  fi
else
  if nmcli device connect enp4s0f3u1u1c2; then
    notify-send "Ethernet включен"
  else
    notify-send "Ошибка при включении Ethernet"
  fi
fi
