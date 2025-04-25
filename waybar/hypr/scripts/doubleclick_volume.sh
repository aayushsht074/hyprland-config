#!/bin/bash

CLICK_FILE="/tmp/waybar_volume_click"
TIMEOUT=0.3  # seconds

now=$(date +%s.%N)

if [[ -f "$CLICK_FILE" ]]; then
    last_click=$(cat "$CLICK_FILE")
    elapsed=$(echo "$now - $last_click" | bc)
    if (( $(echo "$elapsed < $TIMEOUT" | bc -l) )); then
        # Double-click detected
        rm "$CLICK_FILE"
        pavucontrol &
        exit 0
    fi
fi

echo "$now" > "$CLICK_FILE"
