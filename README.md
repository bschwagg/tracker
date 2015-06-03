#Tracker

Add each of your project directories to the config file.  Your time will now be logged automatically.  No more punching in and punching out.

How?
This service monitors for events such as any file in the directory (recursively) being saved, screen lock/unlock, logout/login, etc. and stores that data.  The data is then used to make a report of your work time.


## INSTALLATION
Ubuntu/Debian: <pre>$>sudo dpkg -i tracker_version_all.deb</pre>
Redhat:        <pre>$>sudo rpm -ivh tracker_version.noarch.rpm   #Note: Untested!</pre>

## SERVICE USAGE:
<pre>
sudo systemctl start  tracker
sudo systemctl stop   tracker
sudo systemctl status tracker
</pre>

## APP USAGE (PLANNED):
<pre>
tracker start project (optional otherwise, just when the file is saved)
tracker stop (optional, but helpful, otherwise a logout or shutdown event is used)
tracker --help
tracker -r --report --daily --total <project>
tracker --regen project #if we pre-load reports then regenerate it
</pre>

(optional) TBD: matplotlib may be used for a graphical report of times




