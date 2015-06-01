#!/bin/bash

#All credit for this function goes to: http://ubuntuforums.org/showthread.php?t=1059023
function set_dbus_address
{
# Search these processes for the session variable 
# (they are run as the current user and have the DBUS session variable set)
compatiblePrograms=( pulseaudio nautilus kdeinit kded4  trackerd )

# Attempt to get a program pid
for index in ${compatiblePrograms[@]}; do
	PID=$(pidof -s ${index})
	if [[ "${PID}" != "" ]]; then
		echo "Found an owner at ${index}"
		break
	fi
done
if [[ "${PID}" == "" ]]; then
	echo "Could not detect active login session"
	return 1
fi

QUERY_ENVIRON="$(tr '\0' '\n' < /proc/${PID}/environ | grep "DBUS_SESSION_BUS_ADDRESS" | cut -d "=" -f 2-)"
if [[ "${QUERY_ENVIRON}" != "" ]]; then
	export DBUS_SESSION_BUS_ADDRESS="${QUERY_ENVIRON}"
	bus_address=${QUERY_ENVIRON}
	echo "Found session:"
	echo "DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS}"
else
	echo "Could not find dbus session ID in user environment."
	return 1
fi

return 0
}


#set_dbus_address #not needed since we're running this script from the same user's session

# DESCRIPTION: This command uses gdbus to monitor activity in the session.\
#              For events where the user logs out or screen is locked then\
#              we want to note that they've stopped working. Likewise when\
#              they've logged back in.\
cmd="gdbus monitor -e -d com.canonical.Unity -o /com/canonical/Unity/Session"

if [[ `ps aux | grep "${cmd}"` ]] ; then
	# Tracker already running. No need to start it
else
	# Start the tracker. This is called when the user logs in after the 
	# service first runs to install it.
	${cmd} | 
	( while true
	    do read X
	    if echo $X | grep Session.Locked &> /dev/null; then
	        /opt/tracker/entryAll.sh "lock"
	    elif echo $X | grep Session.Unlocked &> /dev/null; then
	        /opt/tracker/entryAll.sh "unlock"
	    fi
	    done )

fi