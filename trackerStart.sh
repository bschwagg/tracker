#!/bin/bash
 
# Preconfigure triggers for other system events
# Problem: Can't run dbus as root cause it won't connect to the user's session!
# solution:
# if trying to run from root this option latches onto an existing DBUS daemon
# by getting environment vars from the existing dbus session info.
#
# or, why not just run this as the (first) logged-in user with 'su - -c 'command''
#
# or:
# su bschwagg
# /opt/tracker/user_activity.sh &
# sudo -s
#
# still doesn't work. 
#
# Well, only solution that works is to stick this in the login script

current_user=`users | awk '{print $1}'`

#permissions housekeeping
chgrp -R ${current_user} /opt/tracker/logs 
chown -R ${current_user} /opt/tracker/logs
chmod -R +w /opt/tracker/logs


if [[ `grep tracker_register /home/${current_user}/.bashrc` ]] ; then
	echo "Tracker already installed in ${current_user}'s .bashrc"
else
	echo "Installing tracker in ${current_user}'s .bashrc so it loads every session.."
	echo " " >> /home/${current_user}/.bashrc
	echo "# The following entry loads a necessary utility for the tracker service" >> /home/${current_user}/.bashrc
	echo "/opt/tracker/tracker_register.sh &" >> /home/${current_user}/.bashrc

fi


echo "Starting monitors to watch project directories.."
# TODO: This section really needs to be done in python or something more readable..
config_file=/opt/tracker/config.ini
projects=`grep -R "^\[.*\]$" ${config_file} | sed 's/\]//g;s/\[//g'`
for project in ${projects}; 
do
    dir_conf=`sed -e "0,/\[${project}\]/d;/Recursive/,\'$'d;s/Directory = //g" ${config_file} | head -n 1`
	echo "Starting watch on directory ${dir_conf} for project: ${project}"
	/usr/bin/python /usr/local/bin/when-changed ${dir_conf} -v -1 -r -c /opt/tracker/entry.sh ${project} save &
done

#Status reporting
if [[ `ps aux | grep when-changed | grep -v grep` ]] ; then
  echo "Started successfully"
  exit 0
else
  echo "Failed to start!"
  exit 1
fi