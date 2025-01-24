#!/bin/bash

# Function to display IP addresses and status of active network interfaces
display_network_interfaces() {
    echo "Active Network Interfaces and their IP Addresses:"
    ip -brief addr show | grep -v DOWN
}

# Function to show bandwidth usage for each interface
show_bandwidth_usage() {
    echo "Launching bandwidth monitoring with iftop..."
    echo "Press 'q' to quit iftop."
    sudo iftop
}

# Function to monitor network connections and alert if a specific IP connects
monitor_connections() {
    read -p "Enter the IP address to monitor: " target_ip
    echo "Monitoring network connections for $target_ip. Press Ctrl+C to stop."
    while true; do
        ss -tun | grep "$target_ip" &> /dev/null
        if [ $? -eq 0 ]; then
            echo "ALERT: Connection established with $target_ip at $(date)"
        fi
        sleep 5
    done
}

# Function to track network traffic over time and log data
track_network_traffic() {
    log_file="network_traffic.log"
    echo "Tracking network traffic. Logs will be saved to $log_file. Press Ctrl+C to stop."
    echo "Timestamp, Interface, Received (bytes), Transmitted (bytes)" > "$log_file"
    while true; do
        ts=$(date "+%Y-%m-%d %H:%M:%S")
        traffic=$(cat /proc/net/dev | awk 'NR>2 {print $1, $2, $10}')
        while read -r line; do
            iface=$(echo $line | awk '{print $1}' | tr -d ':')
            rx=$(echo $line | awk '{print $2}')
            tx=$(echo $line | awk '{print $3}')
            echo "$ts, $iface, $rx, $tx" >> "$log_file"
        done <<< "$traffic"
        sleep 10
    done
}

# Menu for user to select options
while true; do
    echo
    echo "Network Monitor Tool"
    echo "---------------------"
    echo "1. Display IP Addresses and Status of Active Network Interfaces"
    echo "2. Show Bandwidth Usage for Each Interface"
    echo "3. Monitor Network Connections and Alert on Specific IP"
    echo "4. Track Network Traffic Over Time and Log Data"
    echo "5. Exit"
    read -p "Choose an option (1-5): " choice

    case $choice in
        1)
            display_network_interfaces
            ;;
        2)
            show_bandwidth_usage
            ;;
        3)
            monitor_connections
            ;;
        4)
            track_network_traffic
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
