#!/bin/bash

TEMPERATURE=$(curl -s 'wttr.in/oslo?format=j1' | jq '.current_condition[0].temp_C')
TEMPERATURE=${TEMPERATURE//\"/}

if (( TEMPERATURE > 10 )); then
    lolcat --seed=24 ~/.config/nvim/static/friday_summer.txt
else
    lolcat --seed=24 ~/.config/nvim/static/friday.txt
fi
