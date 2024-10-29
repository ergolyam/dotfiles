#!/bin/bash

if nmcli radio wifi | grep -q "enabled"; then
  if nmcli radio wifi off; then
    notify-send "WiFi off."
  else
    notify-send "Failed to disable WiFi."
  fi
else
  if nmcli radio wifi on; then
    notify-send "WiFi on."
  else
    notify-send "Failed to enable WiFi."
  fi
fi
