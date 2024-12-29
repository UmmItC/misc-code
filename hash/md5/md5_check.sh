#!/bin/bash

is_md5() {
    local hash="$1"

    if [[ -z "$hash" ]]; then
        echo "Input is empty. Please provide a string to check."
        return 1
    fi

    if [[ ${#hash} -eq 32 && "$hash" =~ ^[a-f0-9]+$ ]]; then
        echo "$hash is a valid MD5 hash."
        return 0
    else
        echo "$hash is NOT a valid MD5 hash."
        return 1
    fi
}

read -p "Enter a string to check: " input_string

is_md5 "$input_string"

