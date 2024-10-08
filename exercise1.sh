#!/bin/bash

# Define paths
diff_file="file_diff.txt"
added_file="added.txt"
removed_file="removed.txt"
deploy_package="deployPackage"

# Clear existing content of the output files
> "$added_file"
> "$removed_file"

# Ensure the deployPackage and its subdirectories exist
mkdir -p "$deploy_package/added"
mkdir -p "$deploy_package/removed"

# Read file_diff.txt line by line
while IFS= read -r line; do
    # Extract the status and file path
    status=$(echo "$line" | awk '{print $1}')
    file_path=$(echo "$line" | awk '{print $2}')
    
    # Extract the file name from the file path
    file_name=$(basename "$file_path")
    
    # Categorize the file based on the status
    case "$status" in
        M|A)
            echo "$file_name" >> "$added_file"
            # Copy the file to the added folder
            cp "$file_path" "$deploy_package/added/"
            ;;
        R|D)
            echo "$file_name" >> "$removed_file"
            # Copy the file to the removed folder
            cp "$file_path" "$deploy_package/removed/"
            ;;
        *)
            echo "Unknown status: $status for file $file_path"
            ;;
    esac
done < "$diff_file"

echo "Files have been processed and moved as per their status."
