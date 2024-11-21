#!/bin/bash

# Check if a file is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

# Assign the first argument as the file name
file=$1

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' not found."
    exit 1
fi

# Extract users prefixed with SRC: or TGT:
unique_users=$(grep -E '^(SRC:|TGT:)' "$file" | sed -E 's/^(SRC:|TGT:)//' | sort | uniq)

# Count the number of unique users
unique_count=$(echo "$unique_users" | wc -l)

echo "Number of unique users (SRC or TGT): $unique_count"

