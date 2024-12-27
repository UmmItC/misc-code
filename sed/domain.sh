#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
NC="\033[0m" # No Color

usage() {
    echo -e "${RED}Usage: $0 --url-list <file> --domain-file <domain_file>${NC}"
    exit 1
}

# Check if the correct number of arguments is provided
if [[ $# -ne 4 || $1 != "--url-list" || $3 != "--domain-file" ]]; then
    usage
fi

input_file="$2"
domain_file="$4"
backup_file="${input_file}.bak"

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
    echo -e "${RED}[ERROR] File not found: $input_file${NC}"
    exit 1
fi

# Check if the domain file exists
if [[ ! -f "$domain_file" ]]; then
    echo -e "${RED}[ERROR] Domain file not found: $domain_file${NC}"
    exit 1
fi

mv "$input_file" "$backup_file"
echo -e "${GREEN}[OK] Renamed $input_file to $backup_file${NC}"

# Create a new file for modified URLs
output_file="modified_urls"
> "$output_file"  # Clear the output file if it exists

# Read the domain replacements into an array
declare -a replacements
while IFS='|' read -r old new; do
    replacements+=("$old|$new")
done < "$domain_file"

# Count total URLs
total_urls=$(wc -l < "$backup_file")
processed_count=0

# Read URLs from the backup file and replace domains
while IFS= read -r url; do
    new_url="$url"
    for replacement in "${replacements[@]}"; do
        old_domain="${replacement%|*}"
        new_domain="${replacement#*|}"
        new_url=$(echo "$new_url" | sed "s|$old_domain|$new_domain|g")
    done
    
    # Output the original and modified URL to the terminal
    echo -e "${YELLOW}[INFO] Processed URL: ${NC}$url"
    echo -e "${GREEN}[OK] Modified URL: ${NC}$new_url"
    
    # Write the modified URL to the output file
    echo "$new_url" >> "$output_file"
    
    # Increment the processed count
    ((processed_count++))
done < "$backup_file"

echo -e "${GREEN}[SUMMARY] Processed $processed_count out of $total_urls URLs.${NC}"
echo -e "${GREEN}[OK] Modified URLs saved to $output_file file :)${NC}"
