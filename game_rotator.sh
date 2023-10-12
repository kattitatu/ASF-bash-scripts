#!/bin/bash
# Make sure  jq is installed
if ! command -v jq &> /dev/null; then
	echo "jq is not installed"
	exit 1
fi
config_file="/home/pi/archi/config/Farmi.json"
key_to_read_from="GamesPlayedWhileIdle"
#read the current games list into a string variable
list=$(jq -r '.GamesPlayedWhileIdle' "$config_file")
#need to strip a bunch of unwanted characters from the string and save it to new variable
echo "$list" | tr -d  []"'$'\n''  " > trimmed_string.txt
edited_string=$(cat trimmed_string.txt)
echo "$edited_string"
result=" [ "
is_first="true"
#split the string into an array now
IFS=", " read -ra id_array <<< "$edited_string"
#go through the array and swap first to last, construct a new string to put in the json
for i in  "${id_array[@]}"; do 
	if [ "$is_first" == "true" ]; then
		is_first="false"
	else
		result="${result} ${i},"
	fi
done
result="${result} ${id_array[0]} ]"
echo "${result}"
#write the new json into the config
jq --arg key "$key_to_read_from" --argjson value "${result}" '.[$key] = $value' "$config_file" > Temp.json
mv Temp.json "$config_file"
