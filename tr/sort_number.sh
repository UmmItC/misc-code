#!/bin/bash

# Check if any arguments are passed
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <numbers>"
    exit 1
fi

# Read the input numbers
numbers="$*"

# Sort the numbers and print the result
echo $numbers | tr ' ' '\n' | sort -n | tr '\n' ' '
echo
