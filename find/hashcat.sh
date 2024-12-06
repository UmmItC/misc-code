#!/bin/bash

# Script for cracking all the MD5 hashes in 
# all wordlists under /usr/share/wordlists/ using hashcat

if command -v hashcat &>/dev/null; then
    find /usr/share/wordlists/ -type f -exec hashcat -m 0 -a 0 -d 2 hash {} \;

else
    echo "Hashcat is not installed. Please install it first before running this script."
    exit 1
fi
