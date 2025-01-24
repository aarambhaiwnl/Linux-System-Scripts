#!/bin/bash

#log file to store cpu usage logs
log_file="cpu_usage_logs.txt"

#Function to show current CPU usage
cpu_usage() {
    echo "Current CPU Usage:"
    #mpstat is used to get CPU stats, extracts idle percentage and subtracts 100 from it to calculate current CPU usage
    mpstat | grep -A 5 "%idle" | awk '{print 100 - $12 "%"}'
}

#Function to track and log cpu usage
track_usage() {
    echo "Tracking CPU usage. Logs will be saved in $log_file."
    #Infinite loop to log cpu usage continuously
    while true; do
	#logs data with timestamp
        echo "CPU usage at $(date):" >>"$log_file"
        mpstat | grep -A 5 "%idle" | awk '{print 100 - $12 "%"}' >>"$log_file"
	#seperator line to make the log file more readable
        echo "------------------------------------" >>"$log_file"
        #Pause for 10 seconds before starting next iteration
	sleep 10
    done
}

#Function to set cpu affinity for a process given PID
set_cpu_affinity() {
    #User prompted to enter PID of process they would like to set affinity for
    read -p "Enter PID to set CPU affinity: " pid
    #User prompted to enter what CPUs they want to assign to the process
    read -p "Enter CPUs to assign (e.g., 0,1): " cpus
    #Uses taskset to assign process to the specified CPUs
    if taskset -cp "$cpus" "$pid" 2>/dev/null; then
        echo "Process $pid assigned to CPUs: $cpus"
    else
        #Error message in case command fails
        echo "Failed to set CPU affinity. Check PID and permissions."
    fi
}

#Function to alert the user when CPU usage crosses a limit they specified
high_cpu_usage_alert() {
    #asks user to enter the limit they want to set
    read -p "Enter CPU usage limit (e.g., 90): " limit
    #Infinite loop to continuously track CPU usage
    while true; do
	#Gets cpu usage by calling cpu_usage function and getting the number value from it
        usage=$(cpu_usage | grep -o '[0-9]\+')
	#Checks if a valid CPU usage percentage was extracted
        if [[ -n $usage && $usage =~ ^[0-9]+$ ]]; then
	    #Checks to see if cpu usage is greater than the limit specified
            if (( usage > limit )); then
		#Alerts the user if cpu usage is greater than the limit specified
                echo "High CPU usage detected ($usage%) at $(date)"
            fi
        else
	    #Error message in case of any command issues
            echo "Error in extracting CPU Usage"
        fi
	#Sleeps for 5 seconds before next iteration
        sleep 5
    done
}

#Menu for the user to select what function they would like to use, on an infinite loop until 5 is selected
while true; do
    #Displays menu options
    echo "CPU Manager Tool"
    echo "1. Display CPU Usage"
    echo "2. Track CPU Usage"
    echo "3. Set CPU Affinity"
    echo "4. High CPU Usage Alerter"
    echo "5. Exit"
    read -p "Enter your choice (1-5): " option
    #Executes function corresponding to the number the user has entered
    case $option in
        1) cpu_usage ;;
        2) track_usage ;;
        3) set_cpu_affinity ;;
        4) high_cpu_usage_alert ;;
        5) echo "Exiting CPU Manager Tool"; break ;;
        *) echo "Invalid option selected" ;;
    esac
done
