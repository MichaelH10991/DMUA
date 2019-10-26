#!/bin/bash

# export masters_list=("292031" "312342")
masters_list=("$@")

for i in "${!masters_list[@]}"; do
  echo ${masters_list[$i]}
  res=$(curl "https://api.discogs.com/masters/${masters_list[$i]}" | jq '.')
  # echo $res
  echo $res >> unparsed.json
done

#  parsing response into an array of objects
cat unparsed.json | jq -s > resources/list.json
rm unparsed.json

# compare with file if empty create file and put number for sale for each release

# if inconsistent send email with diff

# save new number for sale

# ======================================================================
# Didnt work for some reason ...
# echo ${response_list[@]} | jq '{.title, .genres}' > list.json
# cat list.json | jq 'map( { title, genres } )' > new.json
# cat list.json | jq '[ .[] | { .title }]'
# =====================================================================
# Does work but sucks ... And doest really work
# loop through list and check discogs for release
# for i in "${!masters_list[@]}"; do
#   res=$(curl "https://api.discogs.com/masters/${masters_list[$i]}" | jq )
#   echo "index: $i length: ${#masters_list[@]}"
#   if [ $i -eq 0 ]; then
#   echo "[$res" >> releases.json
#   elif [ $i -eq $((${#masters_list[@]}-1)) ]; then
#     echo "]" >> releases.json
#   else
#     echo ",$res" >> releases.json
#   fi
# done
# ====================================================================