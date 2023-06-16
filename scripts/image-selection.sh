#!/bin/bash

output=$(uplink ls sj://nix-images)

filenames=($(echo "$output" | awk 'NR>1 {print $NF}'))

PS3="Select a filename: "
select filename in "${filenames[@]}"; do
    if [[ -n $filename ]]; then
        echo "$filename"
        break
    else
        echo "Invalid selection. Please try again."
    fi
done
