#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Create a list of all installed hyprland packages
pacman -Qq | grep '^hypr' > list_hyprland

# Add xdg-desktop-portal-hyprland to the list
echo "xdg-desktop-portal-hyprland" >> list_hyprland

# Count the number of packages
package_count=$(wc -l < list_hyprland)
echo -e "${YELLOW}There are $package_count packages to be managed.${NC}"

# Display the list of packages
echo -e "${GREEN}The following packages will be managed:${NC}"
cat list_hyprland

# Use a while loop to ask the user if they want to reinstall
while true; do
    read -p "$(echo -e "${YELLOW}Do you want to reinstall the packages? (y/n): ${NC}")" answer
    case $answer in
        [Yy]* ) 
            # Remove and install packages
            paru -Rns $(cat list_hyprland)  # Remove the packages
            paru -S --needed - < list_hyprland  # Install the packages
            echo -e "${GREEN}Packages reinstalled.${NC}"
            exit 0  # Exit successfully after reinstallation
            ;;
        [Nn]* ) 
            echo -e "${RED}Exiting without reinstalling.${NC}"
            exit 1  # Exit with status 1
            ;;
        * ) 
            echo -e "${RED}Please answer yes or no.${NC}"
            ;;
    esac
done
