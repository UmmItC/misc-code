#!/bin/bash

# Script for fetching all remotes in all git repositories under a ./root_dir :)

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

root_dir=${1:-.}

root_dir=$(realpath "$root_dir")

echo -e "${BLUE}Starting to fetch all remotes in repositories under $root_dir${RESET}"

find "$root_dir" -type d -name ".git" | while read git_dir; do
    repo_dir=$(dirname "$git_dir")
    
    echo -e "${GREEN}Entering directory: $repo_dir${RESET}"
    
    if [ -d "$repo_dir" ]; then
        cd "$repo_dir" || continue
        
        echo -e "${YELLOW}Fetching all remotes in $repo_dir${RESET}"
        git fetch --all
        
        echo -e "${BLUE}---------------------------------------------------${RESET}"
    else
        echo -e "${RED}Directory $repo_dir does not exist. Skipping.${RESET}"
    fi
done

echo -e "${GREEN}Done fetching all remotes in all repositories.${RESET}"
