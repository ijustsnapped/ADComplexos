#!/bin/bash

# Input file
input_file="wiki-RfA_trimmed.txt"
# Output file
output_file="cleaned_wiki-RfA_trimmed.txt"

# Use awk to process the file
awk '
/^SRC:$/ { skip = 7 }   # If "SRC:" is empty, set a skip counter to 7
skip > 0 { skip--; next } # If skip counter is active, decrement and skip 
lines
{ print }                # Otherwise, print the line
' "$input_file" > "$output_file"

echo "Processing complete. Cleaned file saved as $output_file"
