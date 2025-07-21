#!/usr/bin/env sh

# Get memory usage percentage (rounded)
MEMORY_PERCENT=$(memory_pressure | grep "System-wide memory free percentage" | awk '{print 100-$5}' | sed 's/%//' | awk '{printf "%.0f", $1}')

# If memory_pressure doesn't work, use vm_stat as fallback
if [ -z "$MEMORY_PERCENT" ]; then
    MEMORY_PERCENT=$(vm_stat | awk '
        /Pages free/ { free = $3 }
        /Pages active/ { active = $3 }
        /Pages inactive/ { inactive = $3 }
        /Pages speculative/ { speculative = $3 }
        /Pages wired down/ { wired = $4 }
        END {
            total = free + active + inactive + speculative + wired
            used = active + inactive + wired
            printf "%.0f", (used / total) * 100
        }')
fi

sketchybar --set memory label="${MEMORY_PERCENT}%"