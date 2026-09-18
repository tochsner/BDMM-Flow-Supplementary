#!/usr/bin/env bash

# summarize the final mean likelihood deviation by algorithm from legacy underscore-named out/*.out files.
# run from this dataset folder with Bash 4+; reads out/ without modifying results.

shopt -s nullglob

unset sum count
declare -A sum count

cd out || exit 1

for file in *.out; do
    # Extract algorithm/group name
    if [[ "$file" =~ ^(bdmmflow_random|bdmmflow_random_inverse|bdmmflow|bdmmprime|bdmmflow_preconditioner|bdmmflow_preconditioner_inverse)_ ]]; then
        group="${BASH_REMATCH[1]}"
    else
        continue
    fi

    # Get last line containing "Deviation was"
    last_line=$(grep 'Mean deviation was' "$file" | tail -n 1)
    [[ -z "$last_line" ]] && continue

    # Extract numeric deviation (decimal OR scientific)
    if [[ "$last_line" =~ ([0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)?) ]]; then
        rate="${BASH_REMATCH[1]}"
    else
        echo "File: $file, Error: could not parse deviation. Skipping."
        continue
    fi

    # Floating-point accumulation
    sum["$group"]=$(awk -v a="${sum[$group]:-0}" -v b="$rate" 'BEGIN{print a+b}')
    count["$group"]=$((count["$group"] + 1))

    echo "File: $file, Deviation: $rate"
done

echo
for group in "${!sum[@]}"; do
    avg=$(awk -v s="${sum[$group]}" -v c="${count[$group]}" 'BEGIN{print s/c}')
    echo "$group average deviation: $avg"
done

cd ..
