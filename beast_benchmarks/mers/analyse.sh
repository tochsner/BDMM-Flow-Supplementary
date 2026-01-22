#!/usr/bin/env bash

shopt -s nullglob

declare -A sum count

# Function: convert [Xh][Ym][Zs] -> seconds (all forms, all optional)
time_to_seconds() {
    local t="$1"
    local h=0 m=0 s=0

    if [[ $t =~ ([0-9]+)h ]]; then
        h="${BASH_REMATCH[1]}"
    fi
    if [[ $t =~ ([0-9]+)m ]]; then
        m="${BASH_REMATCH[1]}"
    fi
    if [[ $t =~ ([0-9]+)s ]]; then
        s="${BASH_REMATCH[1]}"
    fi
    local seconds=$((h*3600 + m*60 + s))
    echo "$seconds"
}

cd out

for file in *.out; do
    # Extract group name
    if [[ "$file" =~ ^(bdmmflow_random|bdmmflow|bdmmprime)_ ]]; then
        group="${BASH_REMATCH[1]}"
    else
        continue
    fi

    # Get last non-empty line containing 'Msamples'
    last_line=$(grep 'Msamples' "$file" | tail -n 1)

    # Defensive: Only proceed if we found such a line
    [[ -z "$last_line" ]] && continue

    # Find the token which matches the time format ([0-9]+h)?([0-9]+m)?([0-9]+s)? immediately preceding /Msamples
    # The time format might be attached to (e.g.) 16m53s/Msamples
    # So we search backwards for the column X with /Msamples, then try to extract the time from X itself or its preceding field

    # Find the column with "/Msamples", extract the time part
    time_token=""
    read -ra fields <<< "$last_line"
    for ((i=${#fields[@]}-1; i>=0; i--)); do
        if [[ "${fields[i]}" =~ /Msamples$ ]]; then
            # Try time is attached, e.g., "16m53s/Msamples"
            time_candidate="${fields[i]%/Msamples}"
            if [[ "$time_candidate" =~ ^([0-9]+[hms])+$ ]]; then
                time_token="$time_candidate"
                break
            fi
            # Or, time is the previous field
            if (( i > 0 )) && [[ "${fields[i-1]}" =~ ^([0-9]+[hms])+$ ]]; then
                time_token="${fields[i-1]}"
                break
            fi
        fi
    done

    # If not parsed yet, fallback to previous behavior (awk)
    if [[ -z "$time_token" ]]; then
        # Try to extract the token before '/Msamples' but filter non-time formats
        token=$(echo "$last_line" | awk '{for(i=NF;i>0;i--) if($i~/\/Msamples$/){print $(i-1)}}' | tr -d '[:space:]')
        if [[ "$token" =~ ^([0-9]+[hms])+$ ]]; then
            time_token="$token"
        fi
    fi

    # If couldn't find a proper time_token, skip this file
    if [[ -z "$time_token" ]]; then
        echo "File: $file, Error: Unable to extract time token. Skipping."
        continue
    fi

    seconds=$(time_to_seconds "$time_token")

    # Debug output for time conversion
    echo "File: $file, Extracted time token: '$time_token', Converted to seconds: $seconds"

    sum["$group"]=$((sum["$group"] + seconds))
    count["$group"]=$((count["$group"] + 1))
done

# Print results
for group in "${!sum[@]}"; do
    avg=$((sum["$group"] / count["$group"]))
    echo "$group average time: $avg seconds"
done

cd ..