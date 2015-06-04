#!/bin/bash
# Stop all the monitoring services used by the tracker service

#Do we want to kill off lock/unlock monitor
ps ax | grep "tracker_register.sh" | grep -v grep |  cut -d' ' -f2 | xargs kill -9

echo "Killing off old tracker monitors"
#killall command doesn't work here, so do it manually
for  job in `ps aux | grep when-changed | grep -v grep | awk '{print $2}'`;
do
	echo "Stopping worker job: ${job}"
	kill -9 ${job}
done

/opt/tracker/entryAll.sh "stop_tracker" #maybe this isn't needed

#Report and return the status
if [[ `ps aux | grep -e when-changed -e user_activity.sh | grep -v grep` ]] ; then
	echo "Stopping track SUCCEEDED!"
	exit 0
else
	echo "Stopping tracker FAILED!"
	exit 1
fi