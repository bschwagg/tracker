#!/bin/bash
#Save an event to all files in the logs directory
  
for f in `ls /opt/tracker/logs/`;
do
	/opt/tracker/entry.sh $f $1
done