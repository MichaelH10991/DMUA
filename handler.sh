#!/bin/bash

# the master list
masters_list=("292031" "312342")

# exports the list and  saves state
bash main.sh "${masters_list[@]}"

# cron the cron which compares state
bash cron.sh "${masters_list[@]}"

mv out.txt outputs/