Overview

file_system_monitor_tool.sh is a bash script designed to monitor disk usage and manage files. It provides various functionalities like displaying disk usage, 
listing large files, finding recently modified files, and cleaning up temporary files in system directories. The script is interactive and menu-driven.

How to Use
Ensure the script is executable:
chmod +x file_system_monitor_tool.sh

To run the script:
./file_system_monitor_tool.sh

Choose an option from the menu:

1. Display Disk Usage: Shows the current disk usage for all mounted filesystems.
2. List Top 15 Largest Files: Prompts the user to specify a directory and displays the 15 largest files in that directory.
3. Show Files Modified in the Last 24 Hours: Prompts the user to specify a directory and lists all files modified in the past 24 hours.
4. Clean Temporary Files: Cleans files larger than a user-specified size in /tmp and /var/tmp.
5. Exit: Exits the script.


Options:

Display Disk Usage
Command: df -h
This command shows a human-readable summary of disk space usage for all mounted filesystems.

List Top 15 Largest Files
Commands: du -ah, sort -rh, head -n 15
The du command calculates file sizes, sort arranges them in descending order, and head extracts the top 15 results.

Show Files Modified in the Last 24 Hours
Command: find <directory> -type f -mtime -1, head -n 15
This uses the find command to locate files modified in the last 24 hours (-mtime -1), and head extracts the top 15 results.

Clean Temporary Files
Command: find /tmp /var/tmp -type f -size +<size_threshold> -exec rm -v {} \;
The find command looks for files exceeding the specified size in /tmp and /var/tmp and deletes them.