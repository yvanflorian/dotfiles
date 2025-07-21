#!/usr/bin/env sh

# CPU item with icon
sketchybar --add item        cpu right                       \
           --set cpu         icon="CPU"                      \
                             icon.font="$FONT:Bold:12.0"     \
                             label="0%"                      \
                             label.font="$FONT:Semibold:13.0" \
                             update_freq=60                  \
                             script="$PLUGIN_DIR/cpu.sh"     \
                             background.padding_right=10     \
                             background.padding_left=10      \

# Memory item with icon  
sketchybar --add item        memory right                    \
           --set memory      icon="MEM"                      \
                             icon.font="$FONT:Bold:12.0"     \
                             label="0%"                      \
                             label.font="$FONT:Semibold:13.0" \
                             update_freq=60                  \
                             script="$PLUGIN_DIR/memory.sh"  \
                             background.padding_right=10     \
                             background.padding_left=10      \

# Battery item with icon
sketchybar --add item        battery right                   \
           --set battery     icon=""                         \
                             icon.font="$FONT:Bold:14.0"     \
                             label="0%"                      \
                             label.font="$FONT:Semibold:13.0" \
                             update_freq=60                  \
                             script="$PLUGIN_DIR/battery.sh" \
                             background.padding_right=10     \
                             background.padding_left=10
