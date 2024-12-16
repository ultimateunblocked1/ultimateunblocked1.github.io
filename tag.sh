#!/bin/bash

# initialize an empty array to hold the output
output=()

# function to make everything lowercase
lower_case() {
    echo "${1,,}"
}

# find all index.html files in ./games and its subdirectories
while IFS= read -r file; do
    # get the full directory path and the base name of the directory
    dir_path=$(dirname "$file")
    dir_name=$(basename "$dir_path")

    # extract all parent directory names and capitalize them
    capitalized_dirs=""
    while [ "$dir_path" != "./games" ]; do
        dir_name=$(basename "$dir_path")
        capitalized_dirs="$dir_name $capitalized_dirs"
        dir_path=$(dirname "$dir_path")
    done

    # capitalize each word in the collected directory names for the id
    id=$(echo "$capitalized_dirs" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

    # remove trailing dash if it exists
    id=${id%-}

    # create the button text (as lowercase)
    button_text=$(lower_case "$capitalized_dirs")

    # construct the list item, removing './' from the href
    output+=("<li class=\"games\"><a id=\"$id\" href=\"${file:2}\"><button>$button_text</button></a></li>")
done < <(find ./games -type f -name 'index.html')

# check if any output was generated
if [ ${#output[@]} -eq 0 ]; then
    echo "No index.html files found in ./games."
else
    # sort the output array alphabetically by id
    IFS=$'\n' sorted_output=($(sort <<<"${output[*]}"))
    unset IFS

    # print the sorted output
    printf "%s\n" "${sorted_output[@]}"
fi
