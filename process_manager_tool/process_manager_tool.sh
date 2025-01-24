#!/bin/bash


#Specify log file where process information will be stored
LOGFILE="process_log.txt"

#Function to list all current running processes
function list_processes() {
    #Prints headers for process list
    echo -e "PID\tUSER\t%CPU\t%MEM\tCOMMAND"
    #Uses ps to list all processes, sorted by cpu usage, uses awk to format output
    ps aux --sort=-%cpu | awk '{printf "%s\t%s\t%s\t%s\t%s\n", $2, $1, $3, $4, $11}'
}

#Function to terminate process given the PID
function kill_process() {
    #Prompts user to enter PID of the process they want to terminate
    read -p "Enter the PID of the process to kill: " pid
    # Check if PID is a valid number
    if [[ "$pid" =~ ^[0-9]+$ ]]; then
	#Attempts to kill process with 'kill -9', if successful, it displays success message otherwise displays error message
        kill -9 "$pid" && echo "Process $pid killed successfully." || echo "Failed to kill process 	$pid. Check permissions or PID validity."
    else
	#Error message in case PID is invalid
        echo "Invalid PID. Please enter a numeric Process ID."
    fi
}

#Function to list processes owned by a given user
function user_processes() {
    #Prompts user to enter the username of the user they would like to see processes of
    read -p "Enter the username: " user
    #ps aux and grep are used to retrieve processes and filter processes and awk is used to format output
    ps aux | grep "^$user" | awk '{printf "%s\t%s\t%s\t%s\t%s\n", $2, $1, $3, $4, $11}'
}

#Function to display top five processes that are consuming CPU and top five processes that are consuming memory
function top_five_processes() {
    echo -e "Top 5 Processes by CPU Usage:"
    #Sorts processes by CPU usage, head -n 6 takes the top 5 processes and awk formats the output
    ps aux --sort=-%cpu | head -n 6 | awk '{printf "%s\t%s\t%s\t%s\t%s\n", $2, $1, $3, $4, $11}'
    echo -e "\nTop 5 Processes by Memory Usage:"
    #Sorts processes by CPU usage, head -n 6 takes the top 5 processes and awk formats the output
    ps aux --sort=-%mem | head -n 6 | awk '{printf "%s\t%s\t%s\t%s\t%s\n", $2, $1, $3, $4, $11}'
}

#Function to schedule periodical checks for processes and saves them to the log file
function schedule_checks() {
    #Infinite loop to perform check periodically
    while true; do
	#Appends date and current time to log file
        echo "$(date):" >> "$LOGFILE"
	#calls list_processes and appends the processes to log file
        list_processes >> "$LOGFILE"
	#adds a seperator for better readability of the log file
        echo -e "\n" >> "$LOGFILE"
	#sleeps for 60 seconds before starting next check
        sleep 60
    done
}

#Menu that shows options for the user to select
echo "Process Manager Tool"
echo "1. List all processes"
echo "2. Kill a process"
echo "3. Display processes by user"
echo "4. Show top 5 CPU/memory-consuming processes"
echo "5. Schedule process checks and log"
echo "6. Exit"

#Prompts the user to enter the number corresponding to the function they would like to select
read -p "Enter your option: " option
case $choice in
    1) list_processes ;;
    2) kill_process ;;
    3) user_processes ;;
    4) top_five_processes ;;
    5) schedule_checks ;;
    6) exit ;;
    *) echo "Invalid option" ;;
esac
