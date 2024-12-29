#!/bin/bash

# Function to get the size of a GitHub repository
get_repo_size() {
    local repo_url="$1"
    # Extract the owner and repo name from the URL
    local repo_info=$(echo "$repo_url" | sed -E 's|https?://(www\.)?github\.com/([^/]+)/([^/]+)|\2/\3|')
    
    # Use GitHub API to get repository information
    local api_url="https://api.github.com/repos/$repo_info"
    local size=$(curl -s "$api_url" | jq '.size')

    # Check if the size is less than 1024 KB (1 MB)
    if [ "$size" -lt 1024 ]; then
        echo "Repository size: ${size} KB"
    else
        # Convert size from kilobytes to megabytes
        local size_mb=$(echo "scale=2; $size / 1024" | bc)
        echo "Repository size: ${size_mb} MB"
    fi
}

# Check if the user provided a repository URL
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <repository-url>"
    exit 1
fi

# Get the repository size
get_repo_size "$1"
