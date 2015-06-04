#!/usr/bin/python
import re
from os import walk
from datetime import datetime

logs = []
for (dirpath, dirnames, filenames) in walk('/opt/tracker/logs'):
	#filenames = [dirpath + '/' + f for f in filenames] #to take the full path
	logs.extend(filenames)
	break

# Dumb test for now. Just dump all the logs for all the projects..
times = []
vals = []
for log in logs:
	with open('/opt/tracker/logs/' + log) as f:
		print '*** Project:' + log + ' ***'
		for l in f:
			m = re.match(r"(.*) - (.*)",l)
			if m:
				print 'Event ' + m.group(2) + ' at ' + m.group(1)
				t = datetime.strptime(m.group(1), '%Y-%m-%d %H:%M:%S')
				times.append( t )
				vals.append( 1 )


exit(1)

# To plot it!
import matplotlib.pyplot as plt
#plt.plot( times, vals, 'ro' )
plt.bar(times,vals)
plt.show()

