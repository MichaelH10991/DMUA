#!/bin/bash

masters_list=("$@")

route=resources/list.json

cat $route | jq 'map( { id, artists: [.artists[0].name], title, num_for_sale, lowest_price } )'

for i in "${!masters_list[@]}"; do
  master_id=${masters_list[$i]}
  name=$(cat $route | jq '.[] | select(.id=='$master_id') | .title')
  saved_for_sale=$(cat $route | jq '.[] | select(.id=='$master_id') | .num_for_sale')
  res=$(curl "https://api.discogs.com/masters/$master_id" | jq '.num_for_sale')
  if [ $saved_for_sale -lt $res ]; then
    echo "(($res-$saved_for_sale)) $name record(s) have been listed" >> out.txt
  elif [ $saved_for_sale -gt $res ]; then
    echo "(($saved_for_sale-$res)) $name record(s) have been sold/unlisted" >> out.txt
  else
    echo "nothing has changed for $name: $saved_for_sale:$res" >> out.txt
  fi
done