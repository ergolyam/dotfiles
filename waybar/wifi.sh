#!/bin/bash

if nmcli radio wifi | grep -q "enabled"; then
  if nmcli radio wifi off; then
    notify-send "WiFi выключен"
  else
    notify-send "Ошибка при выключении WiFi"
  fi
else
  if nmcli radio wifi on; then
    notify-send "WiFi включен"
  else
    notify-send "Ошибка при включении WiFi"
  fi
fi
