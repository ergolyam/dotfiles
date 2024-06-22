#!/bin/bash

# Путь к файлу для записи
output_file="$HOME/Видео/Записи экрана/Запись экрана от $(date +'%Y-%m-%d %H-%M-%S').mkv"

# Проверяем, запущен ли wf-recorder
if pgrep -x "wf-recorder" > /dev/null
then
    # Если wf-recorder уже запущен, останавливаем запись
    pkill -x "wf-recorder"
    notify-send "Запись экрана остановлена и сохранена в: $output_file"
else
    # Если wf-recorder не запущен, начинаем запись
    wf-recorder -f "$output_file" -g "$(slurp -d)" &
fi
