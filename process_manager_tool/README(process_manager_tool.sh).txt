README: process_manager_tool.sh

Description: This script acts as a tool to manage and observe system processes on Linux

How to use:

Make sure the process is executable by running chmod +x process_manager_tool.sh (sudo might be needed for this)
Make sure you are in the same directory as the process_manager_tool.sh file and then run ./process_manager_tool.sh (use sudo if any permission errors pop up) 

Script Features:

1: List Processes: This option displays all the running processes and their corresponding details such as the user that the process belongs to, the PID of the process, the CPU usage of the process, the memory usage of the process and the command for each process

2: Kill a Process: This option allows a user to kill a process as long as they provide the PID for that process

3: Filter Processes by User: This option shows the processes that belong to the specific users

4: Highest resource consuming processes: This option displays the top 5 processes that consume the most CPU and the most memory

5: Scheduled checks: This option schedules process checks every 60 seconds and it then logs the results into the given logfile

