#!/bin/bash
#script shuffles the selection of games played in a day. (32 is maxinum)
#randomly chooses 32 games to be displayed that day, runs once a day rn
#rotator script will then rotate these games during the day
selection_array=()

while IFS= read -r game; do
	selection_array+=("$game")
done < "/home/pi/games.txt"

shuffled_array=($(shuf -e "${selection_array[@]}"))
menu=("${shuffled_array[@]:0:32}")

for item in "${menu[@]}"; do
  echo "$item"
done

config_file="/home/pi/archi/config/Farmi.json"
key_to_write_in="GamesPlayedWhileIdle"
result=" [ "
is_first="true"
for i in "${menu[@]}"; do
	if [ "$is_first" == "true" ]; then
		result="${result}${i}"
		is_first="false"
	else
		result="${result}, ${i}"
	fi
done
result="${result} ]"
echo "${result}"
jq --arg key "$key_to_write_in" --argjson value "${result}" '.[$key] = $value' "$config_file" > shuffletemp.json
mv shuffletemp.json "$config_file"
