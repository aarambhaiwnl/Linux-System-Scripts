The memory_manager_tool.sh script is designed to help users monitor and manage system memory usage. 
It provides useful features to display current memory usage, identify memory-heavy processes, clear memory caches and buffers, and alert users when available memory is critically low.

How to Run the Script
Make the Script Executable: If you haven't already, you need to make the script executable by running the following command in the terminal:
chmod +x memory_manager_tool.sh

Run the Script: To run the script, simply execute it from the terminal:
./memory_manager_tool.sh

Interactive Menu: After running the script, you will be presented with a menu that offers the following options:

1. Display Current Memory Usage: Shows total, used, and free memory.
2. List Processes Consuming More Memory: Lists processes that are consuming more than a user-defined amount of memory (in MB).
3. Clear Memory Cache and Buffers: Clears the system's memory cache and buffers to free up memory.
4. Check for Low Available Memory: Alerts the user if the available memory is below 100MB.
5. Exit: Exits the script.

Follow the Prompts: Depending on your choice, the script will perform the selected action and display the results.

Dependencies
The script uses the following commands:

free (for memory usage display)
ps (to list processes)
awk (to process and filter process data)
sync (to sync filesystem changes)
tee (to clear memory cache with elevated privileges)
The script requires sudo access for clearing memory caches. Ensure you have the necessary permissions to execute commands with sudo.

