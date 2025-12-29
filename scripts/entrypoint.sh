#!/bin/sh
# Env Vars:
# WEBHOOK
# CALENDAR

curl -s -o "birthdays.ics" "$CALENDAR"

ICS_FILE="birthdays.ics"
TARGETDATE=$(date +"%m%d")

if [ ! -f "$ICS_FILE" ]; then
    echo "Error: ICS file not found."
    exit 1
fi

# Process the ICS file
echo "--- Birthdays for $(date) from $ICS_FILE ---"

BIRTHDAY=$(gawk -F: '
    /BEGIN:VEVENT/,/END:VEVENT/ {
        if ($1 == "DTSTART;VALUE=DATE") printf "%d ", $2
        if ($1 == "SUMMARY") print $2
    }
' $ICS_FILE | grep $TARGETDATE)

if [ -n "$BIRTHDAY" ];then 
    echo "$BIRTHDAY"
    NAME=$(echo $BIRTHDAY | cut -d' ' -f2- | tr -d '\r' | tr -d '"')
    MESSAGE_CONTENT="Wow! I'm Birthday Ambassador Donnie Yen of good wishes and fortune. Today is $(date +"%A %B %e") and $NAME's Birthday!🎂"
    PAYLOAD="{\"content\": \"$MESSAGE_CONTENT\"}"
    echo $PAYLOAD
    curl -H "Content-Type: application/json" -X POST -d "$PAYLOAD" "$WEBHOOK"
else
    echo "No Birthday :("
fi

exit 0
