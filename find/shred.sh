#!bin/bash

# Script for shredding all files in a directory
# it will shred all files in the current directory
# tool is using shred and srm.

if command -v shred &>/dev/null && command -v srm &>/dev/null; then
    echo "Both shred and srm are installed."
    
    find . -type f -exec shred -uvz {} \;
    shred -uvz *
else
    echo "Shred and/or srm are not installed. Please install both before running this script."
    exit 1
fi
