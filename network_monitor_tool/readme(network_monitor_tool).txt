Overview
network_monitor_tool.sh is a versatile shell script for managing and monitoring network activity. It allows users to view active network interfaces, monitor bandwidth usage, 
track network connections, and log traffic data over time. Designed to be user-friendly, the script provides an interactive menu for selecting the desired task.

How to Use
Ensure the Script is Executable:
chmod +x network_monitor_tool.sh

Run the Script:
./network_monitor_tool.sh

Menu Options:

1. Display IP Addresses and Status of Active Network Interfaces
Shows all active network interfaces and their IP addresses.

2. Show Bandwidth Usage for Each Interface
Launches the iftop tool to monitor bandwidth in real time.

3. Monitor Network Connections and Alert on Specific IP
Prompts the user to input an IP address and monitors active connections. Alerts when the specified IP connects.

4. Track Network Traffic Over Time and Log Data
Continuously tracks traffic statistics for all interfaces and logs them into a file named network_traffic.log.

5. Exit
Exits the script.

Prerequisites

iftop:

Ensure iftop is installed for bandwidth monitoring:

sudo apt install iftop  # For Debian/Ubuntu
sudo yum install iftop  # For CentOS/RHEL

Permissions:
features like iftop and monitoring connection require sudo privileges.

Log File
For option 4, the script creates a log file named network_traffic.log in the current directory. This file contains:

Timestamp
Network interface
Received bytes
Transmitted bytes
