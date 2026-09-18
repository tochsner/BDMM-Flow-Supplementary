#!/usr/bin/env bash

shopt -s nullglob

unset files_with_exception
declare -A files_with_exception

cd out

for file in *.out; do
    # Extract group name
    if [[ "$file" =~ ^(bdmmflow_random|bdmmflow_random_inverse|bdmmflow|bdmmprime|bdmmflow_preconditioner|bdmmflow_preconditioner_inverse)_ ]]; then
        group="${BASH_REMATCH[1]}"
    else
        continue
    fi

    # Check if the file contains "Exception"
    if grep -q "Exception" "$file"; then
        # Append the filename to the list for this group
        files_with_exception["$group"]+="$file "
    fi
done

# Print results
for group in "${!files_with_exception[@]}"; do
    echo "$group files with Exception:"
    for f in ${files_with_exception["$group"]}; do
        echo "  $f"
    done
done

cd ..
