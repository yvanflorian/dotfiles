#!/usr/bin/env sh

# Get CPU usage percentage (rounded)
CPU_PERCENT=$(top -l 1 -s 0 | grep "CPU usage" | awk '{print $3}' | sed 's/%//' | awk '{printf "%.0f", $1}')

# Update the CPU item
sketchybar --set cpu label="${CPU_PERCENT}%"