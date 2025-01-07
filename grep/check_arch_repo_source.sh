#!/bin/bash

# Define color codes
GREEN='\033[0;32m'      # Green for extra
LIGHTBLUE='\033[1;34m'  # Light Blue for multilib
YELLOW='\033[1;33m'     # Yellow for AUR
RED='\033[0;31m'        # Red for not found
NC='\033[0m'            # No Color

# Check if the user provided the --list argument and a file
if [[ "$1" != "--list" || -z "$2" ]]; then
    echo "Usage: $0 --list <file>"
    exit 1
fi

# Read the package names from the specified file
file="$2"

# Check if the file exists
if [[ ! -f "$file" ]]; then
    echo "File not found: $file"
    exit 1
fi

# Function to check if a package is available in the repositories
check_package() {
    local package=$1
    if pacman -Ss "$package" | grep -q "^extra/$package"; then
        echo -e "[ ${GREEN}EXTRA${NC} ] $package is available in the extra repository."
    elif pacman -Ss "$package" | grep -q "^multilib/$package"; then
        echo -e "[ ${LIGHTBLUE}MULTILIB${NC} ] $package is available in the multilib repository."
    elif paru -Ss "$package" | grep -q "^aur/$package"; then
        echo -e "[ ${YELLOW}AUR${NC} ] $package is available in the AUR."
    else
        echo -e "[ ${RED}NOT FOUND${NC} ] $package is NOT available in the extra, multilib, or AUR repositories."
    fi
}

# Read the packages from the file and check each one
while IFS= read -r pkg; do
    # Skip empty lines
    if [[ -z "$pkg" ]]; then
        continue
    fi
    check_package "$pkg"
done < "$file"
