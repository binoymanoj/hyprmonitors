#!/bin/bash

# Tool to control monitors in Hyprland
# by binoy_manoj
# github: https://github.com/binoymanoj

function show_help() {
    echo "Usage: hyprmonitors [on|off|disable|enable]"
    echo ""
    echo "Tool to control monitor power state or enable/disable monitors in Hyprland."
    echo ""
    echo "Options:"
    echo "  on        Turn ON a monitor (DPMS on)"
    echo "  off       Turn OFF a monitor (DPMS off)"
    echo "  enable    Re-enable a previously disabled monitor (via reload)"
    echo "  disable   Disable a monitor (remove from layout)"
    echo "  -h        Show this help message"
    echo ""
    echo "Examples:"
    echo "  hyprmonitors off       # DPMS off a selected monitor"
    echo "  hyprmonitors on        # DPMS on a selected monitor"
    echo "  hyprmonitors disable   # Completely disable a monitor"
    echo "  hyprmonitors enable    # Reload Hyprland config to re-enable"
}

# Validate input
if [[ "$1" == "-h" || -z "$1" ]]; then
    show_help
    exit 0
elif [[ "$1" != "on" && "$1" != "off" && "$1" != "disable" && "$1" != "enable" ]]; then
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

# Display menu (skip for enable)
if [[ "$1" != "enable" ]]; then
    echo "Available monitors:"
    for i in "${!MONITORS[@]}"; do
        echo "[$i] ${MONITORS[$i]}"
    done

    # Prompt for user selection
    read -p "Enter the number of the monitor to $1: " SELECTION

    # Validate selection
    if [[ "$SELECTION" =~ ^[0-9]+$ ]] && [ "$SELECTION" -ge 0 ] && [ "$SELECTION" -lt "${#MONITORS[@]}" ]; then
        SELECTED_MONITOR="${MONITORS[$SELECTION]}"
    else
        echo "Invalid selection."
        exit 1
    fi
fi

# Perform action
case "$1" in
    on|off)
        hyprctl dispatch dpms "$1" "$SELECTED_MONITOR"
        echo "Monitor '$SELECTED_MONITOR' turned $1 via DPMS."
        ;;
    disable)
        hyprctl keyword monitor "$SELECTED_MONITOR,disable"
        echo "Monitor '$SELECTED_MONITOR' has been disabled."
        ;;
    enable)
        hyprctl reload
        echo "Hyprland reloaded. Previously disabled monitors (defined in config) may be enabled."
        ;;
esac
