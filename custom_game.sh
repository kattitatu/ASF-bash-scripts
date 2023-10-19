#!/bin/bash
time_to_display=""
config_file="/home/pi/archi/config/Farmi.json"
json_key="CustomGamePlayedWhileIdle"
current_game="jq -r '.CustomGamePlayedWhileIdle' "$config_file""
#endless loop which checks if time needs to be updated every 5 min.
while [ 1 ]; do
	current_time=$(date +"%H:%M")
	hours=${current_time%%:*}
	minutes=${current_time#*:}
    #round minutes downwards to closest half hour
	if [ "$minutes" -lt "15" ]; then
		minutes="00"
	elif [ "$minutes" -lt "30" ]; then
		minutes="15"
	elif [ "$minutes" -lt "45" ]; then
		minutes="30"
	else
		minutes="45"
	fi
	rounded_time="$hours:$minutes"
	current_rounded_time="$rounded_time"
	if [ "$current_rounded_time" != "$time_to_display" ]; then
		time_to_display=$current_rounded_time
		value="$time_to_display UTC+3"
		echo $value
		jq --arg key "$json_key" --arg value "${value}" '.[$key] = $value' "$config_file" > temp3.json
		mv temp3.json "$config_file"
	fi
	sleep 300
done
