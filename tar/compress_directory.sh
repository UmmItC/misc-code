#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Count the number of directories and store their names
directories=(*)
dir_count=0

# Loop through the items and count directories
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        dir_names+=("$dir")
        ((dir_count++))
    fi
done

# Inform the user about the number of directories found and list them
echo -e "${BLUE}Found $dir_count directories:${NC}"
for dir in "${dir_names[@]}"; do
    echo -e "${YELLOW} - ${dir}${NC}"
done

# Prompt the user for confirmation
while true; do
    read -p "Do you want to compress these directories? [y/n]: " answer
    case $answer in
        [Yy]* ) 
            echo -e "${GREEN}Starting compression...${NC}"
            for dir in "${dir_names[@]}"; do
                echo -e "${YELLOW}Compressing directory: ${dir}...${NC}"
                tar -czvf "${dir}.tar.gz" "$dir" && \
                echo -e "${GREEN}Successfully compressed ${dir} to ${dir}.tar.gz${NC}"
            done
            echo -e "${GREEN}Compression completed for all directories.${NC}"
            break
            ;;
        [Nn]* ) 
            echo -e "${RED}Compression aborted.${NC}"
            exit 0
            ;;
        * ) 
            echo -e "${RED}Please answer yes or no.${NC}"
            ;;
    esac
done
