#!/usr/bin/env sh

# Get CPU usage percentage
CPU_PERCENT=$(top -l 1 -s 0 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')

# Update the CPU percentage item
sketchybar --set cpu.percent label="${CPU_PERCENT}%"

# Get CPU usage for graphs (system and user)
CPU_INFO=$(top -l 1 -s 0 | grep "CPU usage")
CPU_SYS=$(echo $CPU_INFO | awk '{print $5}' | sed 's/%//')
CPU_USER=$(echo $CPU_INFO | awk '{print $3}' | sed 's/%//')

# Update graphs
sketchybar --push cpu.sys $CPU_SYS
sketchybar --push cpu.user $CPU_USER