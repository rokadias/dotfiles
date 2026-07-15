#! /bin/bash

# Requires pulseaudio-utils (pactl); works with PipeWire's pipewire-pulse too.

MUTE=$(pactl get-sink-mute @DEFAULT_SINK@)
if [[ "$MUTE" == *"yes"* ]]; then
	COLOUR="red"
else
	COLOUR="green"
fi

# Returns the current default sink volume
VALUE=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n1)

# Format and print
echo "<fc=$COLOUR>$VALUE</fc>%"
