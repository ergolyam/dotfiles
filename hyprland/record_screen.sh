#!/bin/bash

output_file="$HOME/Videos/Записи экрана/Запись экрана от $(date +'%Y-%m-%d %H-%M-%S').mkv"

if pgrep -x "wf-recorder" > /dev/null
then
    pkill -x "wf-recorder"
    notify-send "Запись экрана остановлена и сохранена в: $output_file"
else
    notify-send "Запись экрана начата"
    wf-recorder -f "$output_file" -g "$(slurp -d)" &
fi
