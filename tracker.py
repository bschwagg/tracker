#!/usr/bin/python

import matplotlib.pyplot as plt
from datetime import datetime

# Dumb test for now...
times = []
vals = []
with open('/opt/tracker/logs/bookstore') as f:
	for l in f:
		if 'bookstore' in l:
			l=l.replace(' - bookstore\n','')
			#t=unix_time_millis( l )
			t = datetime.strptime(l, '%Y-%m-%d %H:%M:%S')
			times.append( t )
			vals.append( 1 )
#plt.plot( times, vals, 'ro' )
plt.bar(times,vals)
plt.show()

