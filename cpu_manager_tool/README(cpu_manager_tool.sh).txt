README(cpu_manager_tool.sh)
 
Explanation:

-Displays CPU Usage, Logs CPU Usage in a log file over time, Allows the user to assign a process to certain CPU cores, Allows the user to monitor CPU usage and triggers an alert if the usage exceeds the given limit by the user

How to use the script:

Make sure it has necessary permissions: use sudo chmod +x cpu_manager_tool.sh

Once it has been given the necessary permissions, make sure you are in the same directory as the script(use cd) and then use ./cpu_manager_tool.sh(use sudo in case of permission problems)

Use sudo apt install sysstat to use mpstat(in case you don't have it installed already)


Script Explanation:

Starts by setting a log file to store the CPU usage logs

cpu_usage(): Displays current CPU usage. Uses mpstat which shows CPU stats and it then filters the idle percentage with grep and subtracts it from 100 while using awk to calculate the CPU usage at that time.

track_usage(): Logs cpu usage every 10 seconds into the specified log file, timestamp and CPU usage are appended into the log file. Script tracks CPU usage in an infinite loop until stopped manually by the user.

set_cpu_affinity(): Allows a user to assign a process(using PID) to specific CPU cores, taskset is used to set CPU affinity. User is prompted to enter the PID of the process they would like to set affinity for as well as the list of CPU cores they want assigned.

high_cpu_usage_alert(): Checks CPU usage and gives an alert to the user if it crosses the limit that the user has specified. Calls cpu_usage, extracts number value of CPU usage and then compares it with the limit that the user gave. If it is greater than the limit, it gives an alert to the user with the current CPU usage.

The main loop is just the menu and it prompts the user to select the menu option they would like to use.