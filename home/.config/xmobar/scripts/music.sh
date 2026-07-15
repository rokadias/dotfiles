#! /bin/bash
#
# Writes the title and artist of the currently playing/paused song (via any
# MPRIS-compatible media player, using playerctl) to STDOUT, formatted for xmobar.
# If nothing is playing or paused, nothing will be written.
# Note: playerctl errors are written to STDERR; xmobar only looks at STDOUT.

TCOL="cyan"         # The colour to be used to draw the song title when playing
ACOL="lightblue"    # The colour to be used to draw the song artist when playing
PCOL="darkred"      # The colour to be used to draw both the song title and artist when paused

STATUS=$(playerctl status 2>/dev/null)
ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

if [ "$STATUS" == "Playing" ]; then
  echo "<fc=$ACOL>$ARTIST</fc> - <fc=$TCOL>$TITLE</fc>"
elif [ "$STATUS" == "Paused" ]; then
  echo "<fc=$PCOL>$ARTIST - $TITLE</fc>"
fi
