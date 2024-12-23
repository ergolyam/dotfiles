#!/usr/bin/env bash

command -v curl >/dev/null 2>&1 || { echo "curl не установлен. Установите curl и попробуйте снова."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "jq не установлен. Установите jq и попробуйте снова."; exit 1; }

declare -A WEATHER_CODES=(
    ["113"]="☀️"
    ["116"]="⛅️"
    ["119"]="☁️"
    ["122"]="☁️"
    ["143"]="🌫"
    ["176"]="🌦"
    ["179"]="🌧"
    ["182"]="🌧"
    ["185"]="🌧"
    ["200"]="⛈"
    ["227"]="🌨"
    ["230"]="❄️"
    ["248"]="🌫"
    ["260"]="🌫"
    ["263"]="🌦"
    ["266"]="🌦"
    ["281"]="🌧"
    ["284"]="🌧"
    ["293"]="🌦"
    ["296"]="🌦"
    ["299"]="🌧"
    ["302"]="🌧"
    ["305"]="🌧"
    ["308"]="🌧"
    ["311"]="🌧"
    ["314"]="🌧"
    ["317"]="🌧"
    ["320"]="🌨"
    ["323"]="🌨"
    ["326"]="🌨"
    ["329"]="❄️"
    ["332"]="❄️"
    ["335"]="❄️"
    ["338"]="❄️"
    ["350"]="🌧"
    ["353"]="🌦"
    ["356"]="🌧"
    ["359"]="🌧"
    ["362"]="🌧"
    ["365"]="🌧"
    ["368"]="🌨"
    ["371"]="❄️"
    ["374"]="🌧"
    ["377"]="🌧"
    ["386"]="⛈"
    ["389"]="🌩"
    ["392"]="⛈"
    ["395"]="❄️"
)

format_time() {
    local time="$1"
    echo "${time/00/}" | awk '{printf "%02d", $0}'
}

format_temp() {
    local temp="$1"
    printf "%-3s°" "$temp"
}

format_chances() {
    local hour_json="$1"
    declare -A chances=(
        ["chanceoffog"]="Fog"
        ["chanceoffrost"]="Frost"
        ["chanceofovercast"]="Overcast"
        ["chanceofrain"]="Rain"
        ["chanceofsnow"]="Snow"
        ["chanceofsunshine"]="Sunshine"
        ["chanceofthunder"]="Thunder"
        ["chanceofwindy"]="Wind"
    )
    
    local conditions=()
    for event in "${!chances[@]}"; do
        value=$(echo "$hour_json" | jq -r ".\"$event\"")
        if [ "$value" -gt 0 ]; then
            conditions+=("${chances[$event]} ${value}%")
        fi
    done
    IFS=", " echo "${conditions[*]}"
}

current_hour=$(date +"%H")

weather_json=$(curl -s "https://wttr.in/?format=j1")

current_location=$(echo "$weather_json" | jq -r '.nearest_area[0].areaName[0].value')
current_country=$(echo "$weather_json" | jq -r '.nearest_area[0].country[0].value')
current_weather_code=$(echo "$weather_json" | jq -r '.current_condition[0].weatherCode')
current_feels_like=$(echo "$weather_json" | jq -r '.current_condition[0].FeelsLikeC')
current_weather_desc=$(echo "$weather_json" | jq -r '.current_condition[0].weatherDesc[0].value')
current_temp=$(echo "$weather_json" | jq -r '.current_condition[0].temp_C')
current_wind=$(echo "$weather_json" | jq -r '.current_condition[0].windspeedKmph')
current_humidity=$(echo "$weather_json" | jq -r '.current_condition[0].humidity')

text="${WEATHER_CODES[$current_weather_code]} ${current_feels_like}°"

tooltip="<b>${current_location}, ${current_country}</b>\n"
tooltip+="<b>${current_weather_desc} ${current_temp}°</b>\n"
tooltip+="Feels like: ${current_feels_like}°\n"
tooltip+="Wind: ${current_wind}Km/h\n"
tooltip+="Humidity: ${current_humidity}%\n"

days=$(echo "$weather_json" | jq -c '.weather[]')

day_index=0
while IFS= read -r day; do
    date=$(echo "$day" | jq -r '.date')
    maxtemp=$(echo "$day" | jq -r '.maxtempC')
    mintemp=$(echo "$day" | jq -r '.mintempC')
    sunrise=$(echo "$day" | jq -r '.astronomy[0].sunrise')
    sunset=$(echo "$day" | jq -r '.astronomy[0].sunset')
    
    tooltip+="\n<b>"
    if [ "$day_index" -eq 0 ]; then
        tooltip+="Today, "
    elif [ "$day_index" -eq 1 ]; then
        tooltip+="Tomorrow, "
    fi
    tooltip+="$date</b>\n"
    tooltip+="⬆️ $maxtemp° ⬇️ $mintemp° 🌅 $sunrise 🌇 $sunset\n"
    
    hours=$(echo "$day" | jq -c '.hourly[]')
    while IFS= read -r hour; do
        time=$(echo "$hour" | jq -r '.time')
        formatted_time=$(format_time "$time")
        
        if [ "$day_index" -eq 0 ]; then
            if [ "$formatted_time" -lt "$((current_hour - 2))" ]; then
                continue
            fi
        fi
        
        weather_code=$(echo "$hour" | jq -r '.weatherCode')
        weather_emoji="${WEATHER_CODES[$weather_code]}"
        feels_like=$(echo "$hour" | jq -r '.FeelsLikeC')
        weather_description=$(echo "$hour" | jq -r '.weatherDesc[0].value')
        chances=$(format_chances "$hour")
        
        formatted_temp=$(format_temp "$feels_like")
        
        tooltip+="$formatted_time $weather_emoji $formatted_temp $weather_description, $chances\n"
    done <<< "$hours"
    
    day_index=$((day_index + 1))
done <<< "$days"

echo "{\"text\":\"$text\",\"tooltip\":\"$tooltip\"}"
