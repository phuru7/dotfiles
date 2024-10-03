#!/bin/bash

# Get memory pressure statistics
memory_pressure=$(memory_pressure)

# Extract free memory percentage and remove the % symbol
free_percentage=$(echo "$memory_pressure" | grep "System-wide memory free percentage:" | awk '{print $5}' | sed 's/%//')

# Calculate used memory percentage (invert free percentage)
used_percentage=$((100 - free_percentage))

echo "RAM: ${used_percentage}%"


