#!/bin/bash

# Find all index.md files and extract thumbnail URLs
find . -type f -name "index.md" -exec awk 'NR<=10 && /thumbnail: .+/{print $2, FILENAME}' {} \; | while read -r url filepath; do
    # Check if the URL starts with "https://"
    if [[ $url == https* ]]; then
        # Trim leading and trailing whitespaces from the URL
        url=$(echo "$url" | tr -d '[:space:]')
        
        # Extract the filename from the URL
        filename=$(basename "$url")

        # Extract the directory path from the original index.md file
        dirpath=$(dirname "$filepath")

        # Change working directory to the target directory
        cd "$dirpath" || exit

        # Download the file using wget
        wget "$url" -O "./featured.${filename##*.}"

        # Optionally, you can print a message indicating the download status
        if [ $? -eq 0 ]; then
            echo "Downloaded and renamed to featured.${filename##*.}"
        else
            echo "Failed to download $filename"
        fi

        # Change back to the original working directory
        cd - || exit
    else
        echo "Skipping non-HTTPS URL: $url"
    fi
done
