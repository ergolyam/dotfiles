#!/bin/bash

# Начальное состояние монитора (не существует)
prev_state="absent"

# Функция для проверки состояния монитора DP-1
check_monitor() {
    # Получаем список мониторов с помощью hyprctl
    monitor_output=$(hyprctl monitors)

    # Проверяем наличие строки "Monitor DP-1" в выводе
    if echo "$monitor_output" | grep -q "Monitor DP-1"; then
        echo "present"
    else
        echo "absent"
    fi
}

# Бесконечный цикл для проверки состояния монитора
while true; do
    # Текущее состояние монитора
    current_state=$(check_monitor)

    # Если состояние изменилось, выводим соответствующее сообщение
    if [ "$current_state" != "$prev_state" ]; then
        if [ "$current_state" == "present" ]; then
            echo "DP-1 появился"
            pkill waybar
            hyprctl keyword monitor eDP-1,disable
            waybar &
        else
            echo "DP-1 пропал"
            pkill waybar
            hyprctl keyword monitor eDP-1,preferred,0x0,1,transform,3
            waybar &
        fi
        # Обновляем предыдущее состояние
        prev_state="$current_state"
    fi

    # Ждем 5 секунд перед следующей проверкой
    sleep 5
done

