#!/bin/bash

# Check if a file and two year parameters are provided
if [ $# -lt 3 ]; then
    echo "Usage: $0 <file> <start_year> <end_year>"
    exit 1
fi

# Assign the arguments to variables
file=$1
start_year=$2
end_year=$3

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# Define the output file name
output_file="${file%.txt}_trimmed.txt"

# Filter entries based on the year range and save to the new file
awk -v start="$start_year" -v end="$end_year" '
BEGIN {RS=""; FS="\n"} # Set record separator as blank lines, field separator as newline
{
    for (i = 1; i <= NF; i++) {
        if ($i ~ /^YEA:/) {
            year = substr($i, index($i, "YEA:") + 4, 4); # Extract the year from "YEA:xxxx"
            if (year >= start && year <= end) {
                print $0; # If the year is within range, print the entire entry
                break; # Stop once a valid year is found in the entry
            }
        }
    }
}
' "$file" > "$output_file"

echo "Filtered entries for years $start_year to $end_year saved to $output_file"

