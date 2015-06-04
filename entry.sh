#!/bin/bash
#Creates an entry by event name and log file name including a timestamp

if [ -z "$1" ]; then
 echo "Usage: $0 log_filname event_name" 
 exit 1
fi

NAME="UNKNOWN"
if [ ! -z "$2" ]; then
	NAME="$2"
fi
FORMAT='%F %T'
FILE="/opt/tracker/logs/$1"

echo $(date +"$FORMAT") - ${NAME} >> ${FILE}
