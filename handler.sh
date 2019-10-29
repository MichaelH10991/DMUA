#!/bin/bash

timestamp() {
  date +"%T"
}

# the master list
masters_list=("292031" "238337")

# creates state
# bash main.sh "${masters_list[@]}"

# cron the cron which compares state
bash cron.sh "${masters_list[@]}"

# mv out.txt outputs/"$(timestamp)"out.txt