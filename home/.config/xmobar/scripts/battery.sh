#! /bin/bash
#
# Writes battery charge/status to STDOUT, formatted for xmobar.
# Reads sysfs directly, so no acpi package is required. If the machine has no
# battery (e.g. a desktop), nothing is written and this plugin disappears
# from the bar instead of showing an error.
# The leading " | " separator is printed here (rather than in xmobarrc's
# template) so the separator itself vanishes along with the value when
# there's no battery, instead of leaving a bare double pipe.

LOWCOL="darkred"       # colour for charge below LOWTHRESH
NORMALCOL="darkorange" # colour for charge between LOWTHRESH and HIGHTHRESH
HIGHCOL="darkgreen"    # colour for charge above HIGHTHRESH
CHARGECOL="#dAA520"    # colour for the "Charging" label
FULLCOL="#006000"      # colour for the "Charged" label
LOWTHRESH=10
HIGHTHRESH=40

BAT=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' 2>/dev/null | head -n1)

if [ -z "$BAT" ]; then
  exit 0
fi

CAPACITY=$(cat "$BAT/capacity")
STATUS=$(cat "$BAT/status") # "Charging", "Discharging", "Full", "Not charging"

if [ "$STATUS" == "Charging" ]; then
  echo " | <fc=$CHARGECOL>Charging</fc> $CAPACITY%"
elif [ "$STATUS" == "Full" ]; then
  echo " | <fc=$FULLCOL>Charged</fc>"
else
  if [ "$CAPACITY" -le "$LOWTHRESH" ]; then
    COLOUR=$LOWCOL
  elif [ "$CAPACITY" -le "$HIGHTHRESH" ]; then
    COLOUR=$NORMALCOL
  else
    COLOUR=$HIGHCOL
  fi
  echo " | <fc=$COLOUR>$CAPACITY%</fc>"
fi
