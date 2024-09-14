#!/bin/bash

# -- Pipeline 1

# File for saving results
OUTPUT_FILE="system_monitoring.txt"

# Command to monitor processes sorted by CPU and memory usage
ps aux --sort=-%cpu,-%mem | awk '{print $1, $2, $3, $4, $11}' > $OUTPUT_FILE

# Output message indicating completion
echo "Processes sorted by CPU and memory usage have been saved to $OUTPUT_FILE"

# -- Pipeline 2

# Directories to compare
DIR1="/Administration/dir1"
DIR2="/Administration/dir2"

# File for saving directory comparison results
COMPARE_OUTPUT="directory_comparison.txt"

# Command to compare files in two directories and save the differences
find "$DIR1" -type f | sort > dir1_files.txt
find "$DIR2" -type f | sort > dir2_files.txt
diff dir1_files.txt dir2_files.txt > $COMPARE_OUTPUT

# Output message indicating completion
echo "Directory comparison completed. Results saved to $COMPARE_OUTPUT"

# Clean up temporary files
rm dir1_files.txt dir2_files.txt

# -- Pipeline 3

# Directory to search for text files
DIRECTORY="/Administration/dir1"

# File to save the total line count
OUTPUT_FILE="total_lines.txt"

# Find all text files in the specified directory, count lines, and save the total count
find "$DIRECTORY" -type f -name "*.txt" -print0 | xargs -0 wc -l > $OUTPUT_FILE

# Output message indicating completion
echo "Total number of lines in text files has been saved to $OUTPUT_FILE"

# -- Pipeline 4

# File for saving disk space usage
OUTPUT_FILE="disk_space_usage.txt"

# Command to monitor disk space usage, sort by used space, and save the results
df -h | awk 'NR==1 {print $0} NR>1 {print $0 | "sort -k5 -h"}' > $OUTPUT_FILE

# Output message indicating completion
echo "Disk space usage has been saved to $OUTPUT_FILE"

# -- Pipeline 5

# Directory containing log files
LOG_DIR="/Administration/logs"

# Key word to search for
KEYWORD="error"

# Output file for filtered and sorted results
FILTERED_FILE="filtered_logs.txt"

# Archive file name
ARCHIVE_FILE="filtered_logs.tar.gz"

# Combine log files, filter lines with the key word, process with awk, sort and save to a file
cat "$LOG_DIR"/*.log | grep -i "$KEYWORD" | awk '{print $0}' | sort > $FILTERED_FILE

# Archive the filtered results
tar -czf $ARCHIVE_FILE $FILTERED_FILE

# Output message indicating completion
echo "Filtered and sorted log results have been archived in $ARCHIVE_FILE"