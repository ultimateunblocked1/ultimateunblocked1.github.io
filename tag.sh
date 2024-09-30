#!/bin/bash

# Initialize an empty array to hold the output
output=()

# Function to capitalize the first letter of each word (title case)
title_case() {
    echo "$1" | awk '{ for(i=1;i<=NF;i++) { 
        if (length($i) > 0) { 
            $i = toupper(substr($i,1,1)) tolower(substr($i,2)); 
        } 
    } print }'
}

# Find all index.html files in ./games and its subdirectories
while IFS= read -r file; do
    # Get the full directory path and the base name of the directory
    dir_path=$(dirname "$file")
    dir_name=$(basename "$dir_path")

    # Extract all parent directory names and capitalize them
    capitalized_dirs=""
    while [ "$dir_path" != "./games" ]; do
        dir_name=$(basename "$dir_path")
        capitalized_dirs="$dir_name $capitalized_dirs"
        dir_path=$(dirname "$dir_path")
    done

    # Capitalize each word in the collected directory names for the id
    id=$(echo "$capitalized_dirs" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

    # Remove trailing dash if it exists
    id=${id%-}

    # Create the button text and capitalize the first letter of each word
    button_text=$(title_case "$capitalized_dirs")

    # Construct the list item, removing the './' from the href
    output+=("<li class=\"games\"><a id=\"$id\" href=\"${file:2}\"><button>$button_text</button></a></li>")
done < <(find ./games -type f -name 'index.html')

# Check if any output was generated
if [ ${#output[@]} -eq 0 ]; then
    echo "No index.html files found in ./games."
else
    # Sort the output array alphabetically by id
    IFS=$'\n' sorted_output=($(sort <<<"${output[*]}"))
    unset IFS

    # Print the sorted output
    printf "%s\n" "${sorted_output[@]}"
fi
