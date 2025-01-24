#!/bin/bash

# Function to display current memory usage
display_memory_usage() {
    echo "Current Memory Usage:"
    free -m
}

# Function to list processes consuming more than specified memory
list_heavy_processes() {
    read -p "Enter minimum memory usage in MB: " mem_threshold
    echo "Processes consuming more than $mem_threshold MB of memory:"
     ps aux --sort=-rss | awk -v threshold=$mem_threshold '$6/1024 >= threshold {print $1, $6/1024 " MB", $11}' | head -n 20
}

# Function to clear cache and buffers
clear_memory_cache() {
    echo echo "Clearing memory cache and buffers..."
    sudo sync
    echo 3 | sudo tee /proc/sys/vm/drop_caches

    echo "Memory cache and buffers cleared."
}

# Function to set an alert for low available memory
check_low_memory() {
    available_memory=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    available_memory_mb=$((available_memory / 1024))  # Convert from KB to MB

    if [ $available_memory_mb -lt 100 ]; then
        echo "ALERT: Available memory is below 100MB! Only ${available_memory_mb}MB left."
    else
        echo "Memory status is fine. ${available_memory_mb}MB available."
    fi
}

# Main menu function
main_menu() {
    echo "==================================="
    echo "Memory Manager Tool"
    echo "==================================="
    echo "1. Display Current Memory Usage"
    echo "2. List Processes Consuming More Memory"
    echo "3. Clear Memory Cache and Buffers"
    echo "4. Check for Low Available Memory"
    echo "5. Exit"
    echo "==================================="
    read -p "Choose an option (1-5): " choice

    case $choice in
        1)
            display_memory_usage
            ;;
        2)
            list_heavy_processes
            ;;
        3)
            clear_memory_cache
            ;;
        4)
            check_low_memory
            ;;
        5)
            echo "Exiting the script."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}

# Loop to display the menu and execute the selected option
while true; do
    main_menu
done
