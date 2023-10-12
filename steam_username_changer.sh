#!/bin/bash
api_url="http://localhost:1242/Api/Command"
time_to_display=""
#endless loop which checks if time needs to be updated every 5 min.
while [ 1 ]; do
	current_time=$(date +"%H:%M")
	hours=${current_time%%:*}
	minutes=${current_time#*:}
    #round minutes downwards to closest half hour
	if [ "$minutes" -lt "30" ]; then
		minutes="00"
	else
		minutes="30"
	fi
	rounded_time="$hours:$minutes"
	current_rounded_time="$rounded_time"
    #check if this is different than current username
	if [ "$current_rounded_time" != "$time_to_display" ]; then
        #form the valid json
		time_to_display=$current_rounded_time
		value="nickname Farmi kattitatu ~ $time_to_display"
		json_data='{ "Command": "nickname Farmi kattitatu" }'
		modified_data=$(jq --argjson value "\"$value\"" '.Command = $value' <<< "$json_data")
		echo $modified_data
        #make the call, you must include your ASF IPC password here for it to authenticate. I added it as a header
		curl -H "Content-Type: application/json" -H "Authentication: YourPassWord" -X POST -d "$modified_data" "$api_url"
	fi
	sleep 300
done