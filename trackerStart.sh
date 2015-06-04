#!/bin/bash
# This script launches all the monitoring services for file saves and logout/login events

# Setup the session for the user signed in (not root user)
# TODO: This needs to be either specified or more reliable
current_user=`users | awk '{print $1}'`

#permissions housekeeping
chgrp -R ${current_user} /opt/tracker/logs 
chown -R ${current_user} /opt/tracker/logs
chmod -R 777 /opt/tracker/logs  #instead of making a 'tracker' group for permissions

# Start the event monitoring
if [[ `grep tracker_register /home/${current_user}/.bashrc` ]] ; then
	echo "Tracker already installed in ${current_user}'s .bashrc"
	echo "Please restart to have login/log-out monitoring enabled"
else
	echo "Installing tracker in ${current_user}'s .bashrc so it loads every session.."
	echo " " >> /home/${current_user}/.bashrc
	echo "# The following entry loads a necessary utility for the tracker service" >> /home/${current_user}/.bashrc
	echo "/opt/tracker/tracker_register.sh &" >> /home/${current_user}/.bashrc
fi

# TODO: This section really needs to be done in python or something more readable..
echo "Starting monitors to watch project directories.."
config_file=/opt/tracker/config.ini
projects=`grep -R "^\[.*\]$" ${config_file} | sed 's/\]//g;s/\[//g'`
for project in ${projects}; 
do
    dir_conf=`sed -e "0,/\[${project}\]/d;/Recursive/,\'$'d;s/Directory = //g" ${config_file} | head -n 1`
	echo "Starting watch on directory ${dir_conf} for project: ${project}"
	/usr/bin/python /usr/local/bin/when-changed ${dir_conf} -v -1 -r -c /opt/tracker/entry.sh ${project} save &
done

/opt/tracker/entryAll.sh "start_tracker" #maybe this isn't needed

# Status reporting
if [[ `ps aux | grep when-changed | grep -v grep` ]] ; then
  echo "Started successfully"
  exit 0
else
  echo "Failed to start!"
  exit 1
fi