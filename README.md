#Tracker

Add each of your project directories to the config file.  Your time will now be logged automatically.  No more punching in and punching out.

How?
This service monitors for events such as any file in the directory (recursively) being saved, screen lock/unlock, logout/login, etc. and stores that data.  The data is then used to make a report of your work time.


-----------------

APP USAGE (PLANNED):
tracker start <project> (optional otherwise, just when the file is saved)
tracker stop (optional, but helpful, otherwise a logout or shutdown event is used)
tracker --help
tracker -r --report --daily --total <project>
tracker --regen <project> #if we pre-load reports then regenerate it

SERVICE USAGE:
sudo systemctl daemon-reload
sudo systemctl enable tracker
sudo systemctl start tracker
sudo systemctl status tracker

DEPENDENCIES: 
when-changed: install from https://github.com/joh/when-changed
ubuntu with systemd

FRONT END GUI: 
matplotlib for a graphical report. 
TBD Can highlight days to get totals.

NOTES/TODO:
What other events are needed for the record?
Can we dump detailed records for easy pre-loading
Make as an RPM, install and start service.
 TODO rpm notes...
 -Create a service: /usr/lib/systemd/system/tracker.service
 -setup /opt/tracker/ directory for installation of program scripts and data
 -ln -s /usr/bin/tracker /opt/tracker/tracker.py (or tracker.sh)