#!/bin/bash

dl_circuitpython_url="https://downloads.circuitpython.org/bin/raspberry_pi_pico2/en_US/adafruit-circuitpython-raspberry_pi_pico2-en_US-9.2.4.uf2"

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

check_dependencies() {
    # Check if wget is installed
    if ! command -v wget &> /dev/null; then
        echo -e "${COLOR_RED}wget is not installed.${COLOR_NC}"
        echo -e "${COLOR_YELLOW}Please install wget using 'sudo apt install wget' and try again.${COLOR_NC}"
        exit 1
    fi

    if ! command -v lsusb &> /dev/null; then
        echo -e "${COLOR_RED}lsusb is not installed.${COLOR_NC}"
        echo -e "${COLOR_YELLOW}Please install lsusb using 'sudo apt install usbutils' and try again.${COLOR_NC}"
        exit 1
    fi
}

check_dependencies

# Check if the Raspberry Pi USB device is connected
if lsusb | grep -q "RP2350"; then
    echo -e "${COLOR_GREEN}Detected Raspberry Pi Pico 2 Connected.${COLOR_NC}"

    # Check if the device is mounted
    if mount | grep -q "/media/$USER/RP2350"; then
        echo "Device is mounted."
        
        # Change to the mounted directory
        cd "/media/$USER/RP2350" || { echo -e "${COLOR_RED}Failed to change directory.${COLOR_NC}"; exit 1; }
        echo -e "${COLOR_GREEN}Changed directory to $(pwd).${COLOR_NC}"

        # Download CircuitPython UF2 file
        wget $dl_circuitpython_url || { echo -e "${COLOR_RED}Failed to download CircuitPython UF2 file.${COLOR_NC}"; exit 1; }

        echo -e "${COLOR_GREEN}The CircuitPython UF2 file has been downloaded and saved in $(pwd).${COLOR_NC}"
        echo -e "${COLOR_GREEN}The Raspberry Pi Pico 2 should be now keep lighting up and down.${COLOR_NC}"
        echo -e "${COLOR_GREEN}Please now replug raspberry pi pico 2 and mount it again.${COLOR_NC}"
        echo -e "${COLOR_GREEN}The installation of CircuitPython has been completed.${COLOR_NC}"
    elif mount | grep -q "/media/$USER/CIRCUITPY"; then
        echo -e "${COLOR_YELLOW}Seems like this device is already installed with CircuitPython.${COLOR_NC}"
        echo -e "${COLOR_YELLOW}There is no need to install CircuitPython again.${COLOR_NC}"
        exit 1
    else
        echo -e "${COLOR_YELLOW}Device is not mounted. Please mount the device and try again.${COLOR_NC}"
    fi
elif lsusb | grep -q "Raspberry Pi Pico 2"; then
    echo -e "${COLOR_GREEN}Seems like this raspberry pi pico 2 alreday installed with CircuitPython.${COLOR_NC}"
    echo -e "${COLOR_GREEN}There is no need to install CircuitPython again.${COLOR_NC}"
    exit 1
else
    echo -e "${COLOR_RED}Raspberry Pi Pico 2 not detected. Please connect the device and try again.${COLOR_NC}"
fi
