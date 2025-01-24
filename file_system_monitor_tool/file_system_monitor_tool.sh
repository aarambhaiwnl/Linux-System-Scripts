#!/bin/bash

# Function to display disk usage
display_disk_usage() {
    echo "Disk Usage for each Mounted Filesystem:"
    df -h
}

# Function to list the top 15 largest files in a specified directory
list_largest_files() {
    read -p "Enter the directory to analyze: " directory
    if [ -d "$directory" ]; then
        echo "Top 15 Largest Files in $directory:"
        du -ah "$directory" 2>/dev/null | sort -rh | head -n 15
    else
        echo "Error: $directory is not a valid directory."
    fi
}

# Function to show files modified within the last 24 hours
show_recent_files() {
    read -p "Enter the directory to search: " directory
    if [ -d "$directory" ]; then
        echo "Files modified in the last 24 hours in $directory:"
        find "$directory" -type f -mtime -1 2>/dev/null | head -n 15
    else
        echo "Error: $directory is not a valid directory."
    fi
}

# Function to clean temporary files in /tmp and /var/tmp exceeding a specified size
clean_temp_files() {
    read -p "Enter the size threshold (e.g., 100M for 100 MB): " size_threshold
    echo "Cleaning files in /tmp and /var/tmp exceeding $size_threshold..."

    # Clean files in /tmp
    echo "Cleaning /tmp..."
    find /tmp -type f -size +"$size_threshold" -exec rm -v {} \;

    # Clean files in /var/tmp
    echo "Cleaning /var/tmp..."
    find /var/tmp -type f -size +"$size_threshold" -exec rm -v {} \;

    echo "Cleanup complete."
}

# Menu for user to select options
while true; do
    echo
    echo "File System Monitor Tool"
    echo "-------------------------"
    echo "1. Display Disk Usage"
    echo "2. List Top 15 Largest Files"
    echo "3. Show Files Modified in the Last 24 Hours"
    echo "4. Clean Temporary Files in /tmp and /var/tmp Exceeding a Specified Size"
    echo "5. Exit"
    read -p "Choose an option (1-5): " choice

    case $choice in
        1)
            display_disk_usage
            ;;
        2)
            list_largest_files
            ;;
        3)
            show_recent_files
            ;;
        4)
            clean_temp_files
            ;;
        5)
            echo "Exiting the tool. Goodbye!"
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
