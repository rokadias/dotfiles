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

# Send a single desktop notification when charge drops to/below LOWTHRESH
# while discharging. A state file dedupes repeat notifications across polls
# (this script runs every few seconds) and resets once charging or above
# threshold again, so the next drop below LOWTHRESH re-notifies.
NOTIFY_STATE="${XDG_RUNTIME_DIR:-/tmp}/xmobar_battery_low_notified"
if [ "$STATUS" == "Discharging" ] && [ "$CAPACITY" -le "$LOWTHRESH" ]; then
  if [ ! -e "$NOTIFY_STATE" ] && command -v notify-send >/dev/null 2>&1; then
    notify-send -u critical "Low battery" "${CAPACITY}% remaining"
    touch "$NOTIFY_STATE"
  fi
else
  rm -f "$NOTIFY_STATE"
fi

# Instantaneous power draw, in microwatts. Prefer power_now; some hardware
# only exposes current_now/voltage_now, so derive it from those instead.
if [ -r "$BAT/power_now" ]; then
  POWER_UW=$(cat "$BAT/power_now")
elif [ -r "$BAT/current_now" ] && [ -r "$BAT/voltage_now" ]; then
  POWER_UW=$(( $(cat "$BAT/current_now") * $(cat "$BAT/voltage_now") / 1000000 ))
fi

# Energy remaining until empty (discharging) or full (charging), in µWh.
# Prefer energy_now/energy_full; some hardware (many ThinkPads included)
# reports charge in µAh instead, which needs converting via voltage_now.
if [ "$STATUS" == "Charging" ] && [ -r "$BAT/energy_now" ] && [ -r "$BAT/energy_full" ]; then
  REMAINING_UWH=$(( $(cat "$BAT/energy_full") - $(cat "$BAT/energy_now") ))
elif [ "$STATUS" == "Discharging" ] && [ -r "$BAT/energy_now" ]; then
  REMAINING_UWH=$(cat "$BAT/energy_now")
elif [ -r "$BAT/voltage_now" ] && [ "$STATUS" == "Charging" ] && [ -r "$BAT/charge_now" ] && [ -r "$BAT/charge_full" ]; then
  REMAINING_UAH=$(( $(cat "$BAT/charge_full") - $(cat "$BAT/charge_now") ))
  REMAINING_UWH=$(( REMAINING_UAH * $(cat "$BAT/voltage_now") / 1000000 ))
elif [ -r "$BAT/voltage_now" ] && [ "$STATUS" == "Discharging" ] && [ -r "$BAT/charge_now" ]; then
  REMAINING_UWH=$(( $(cat "$BAT/charge_now") * $(cat "$BAT/voltage_now") / 1000000 ))
fi

# "<watts>W (<timeleft>)", or empty if the kernel doesn't expose power/energy
RATE=""
if [ -n "$POWER_UW" ] && [ "$POWER_UW" -gt 0 ]; then
  RATE=$(awk -v p="$POWER_UW" -v r="$REMAINING_UWH" 'BEGIN {
    out = sprintf("%.1fW", p / 1000000)
    if (r != "") {
      hrs = r / p
      h = int(hrs)
      m = int((hrs - h) * 60)
      out = out sprintf(" (%d:%02d)", h, m)
    }
    printf "%s", out
  }')
fi

if [ "$STATUS" == "Charging" ]; then
  MSG="$CAPACITY%"; [ -n "$RATE" ] && MSG="$MSG $RATE"
  echo " | Batt: <fc=$CHARGECOL>Charging</fc> $MSG"
elif [ "$STATUS" == "Full" ]; then
  echo " | Batt: <fc=$FULLCOL>Charged</fc>"
else
  if [ "$CAPACITY" -le "$LOWTHRESH" ]; then
    COLOUR=$LOWCOL
  elif [ "$CAPACITY" -le "$HIGHTHRESH" ]; then
    COLOUR=$NORMALCOL
  else
    COLOUR=$HIGHCOL
  fi
  MSG="$CAPACITY%"; [ -n "$RATE" ] && MSG="$MSG $RATE"
  echo " | Batt: <fc=$COLOUR>$MSG</fc>"
fi
