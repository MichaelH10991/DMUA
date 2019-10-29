#!/bin/bash

timestamp() {
  date +"%T"
}

masters_list=("$@")
GREEN='\u001b[32m'
WHITE='\u001b[37m'
RED_BACK='\e[41m'
DEFAULT_BACK='\e[49m'
route=resources/list.json

# cat $route | jq 'map( { id, artists: [.artists[0].name], title, num_for_sale, lowest_price } )'

for i in "${!masters_list[@]}"; do
  time="$(timestamp)"
  master_id=${masters_list[$i]}
  name=$(cat $route | jq '.[] | select(.id=='$master_id') | .title')
  artist=$(cat $route | jq '.[] | select(.id=='$master_id') | .artists[0].name')
  echo -e "comparing state for ${GREEN}$artist $name${WHITE}"
  saved_for_sale=$(cat $route | jq '.[] | select(.id=='$master_id') | .num_for_sale')
  res=$(curl -s "https://api.discogs.com/masters/$master_id" | jq '.num_for_sale')

  if [ $saved_for_sale -lt $res ]; then
    echo -e "$time: ${RED_BACK}$(($res-$saved_for_sale))${DEFAULT_BACK} ${GREEN}$artist: $name${WHITE} record(s) have been listed"
    echo "$time: $(($res-$saved_for_sale)) $artist: $name record(s) have been listed" >> outputs/out.txt
  elif [ $saved_for_sale -gt $res ]; then
    echo -e "$time: ${RED_BACK}$(($saved_for_sale-$res))${DEFAULT_BACK} ${GREEN}$artist: $name${WHITE} record(s) have been sold/unlisted"
    echo "$time: $(($saved_for_sale-$res)) $artist: $name record(s) have been sold/unlisted" >> outputs/out.txt
  else
    echo -e "$time: nothing has changed for ${GREEN}$artist: $name${WHITE}: ${RED_BACK}$saved_for_sale:$res${DEFAULT_BACK}"
    echo "$time: nothing has changed for $artist: $name: $saved_for_sale:$res" >> outputs/out.txt
  fi
done

# update state
bash main.sh "${masters_list[@]}"