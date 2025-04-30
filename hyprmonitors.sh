#!/bin/bash

# Tool to turn on/off monitor in Hyprland
# by binoy_manoj
# github: https://github.com/binoymanoj

function show_help() {
    echo "Usage: hyprmonitors [on|off]"
    echo ""
    echo "Tool to control monitor power state in Hyprland."
    echo ""
    echo "Options:"
    echo "  on       Turn ON a monitor"
    echo "  off      Turn OFF a monitor"
    echo "  -h       Show this help message"
    echo ""
    echo "Example:"
    echo "  hyprmonitors off    # Turn off a selected monitor"
    echo "  hyprmonitors on     # Turn on a selected monitor"
}

# Validate input
if [[ "$1" == "-h" || -z "$1" ]]; then
    show_help
    exit 0
elif [[ "$1" != "on" && "$1" != "off" ]]; then
    echo "Invalid argument: $1"
    show_help
    exit 1
fi

# Fetch monitor names
readarray -t MONITORS < <(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Check if monitors were found
if [ ${#MONITORS[@]} -eq 0 ]; then
    echo "No monitors found via hyprctl."
    exit 1
fi

# Display menu
echo "Available monitors:"
for i in "${!MONITORS[@]}"; do
    echo "[$i] ${MONITORS[$i]}"
done

# Prompt for user selection
read -p "Enter the number of the monitor to turn $1: " SELECTION

# Validate selection
if [[ "$SELECTION" =~ ^[0-9]+$ ]] && [ "$SELECTION" -ge 0 ] && [ "$SELECTION" -lt "${#MONITORS[@]}" ]; then
    SELECTED_MONITOR="${MONITORS[$SELECTION]}"
    hyprctl dispatch dpms "$1" "$SELECTED_MONITOR"
    echo "Monitor '$SELECTED_MONITOR' turned $1."
else
    echo "Invalid selection."
    exit 1
fi
