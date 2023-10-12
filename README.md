## Steam Username Changer

Uses these to work
https://github.com/JustArchiNET/ArchiSteamFarm/wiki/IPC#asf-api
https://github.com/JustArchiNET/ArchiSteamFarm/wiki/IPC
https://github.com/JustArchiNET/ArchiSteamFarm/wiki/IPC#swagger-documentation

ASF API allows you to do almost anything related to your steam account or steam actions.
This was only testing to see how to make it work. If I get any good ideas I might try implementing them.
Script just changes my steam accounts username to include 0.5 hour precise clock. At first I tried to do something more precise and fast, but seems that Steam rate limits changes to username etc. if you make too many in a short period. 
I got a cron job to stop and start the script once a day, so the accuracy with "sleeps" and them hitting correct timeframes won't shift too much.
Example of my username when it's 11:04

![image](https://github.com/kattitatu/ASF-bash-scripts/assets/146649947/7b4f19f6-1ece-4203-b7b5-3c5bd4667b86)


## Game Rotator

So basically Archi displays the game that's ID is the first in the json list of GamesPlayedWhileIdle.
This is just a script to rotate that first spot so it doesn't display the same game 24/7. 
Right now this script is ran every 15 minutes. This one doesn't use any APIs, but only makes changes to JSON config document that triggers ASF to relaunch the corresponding bot with new information.
I'm sure there is a more efficient way to do this, but I don't want to spend time making the script prettier.
