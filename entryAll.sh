#!/bin/bash
  
for f in `ls /opt/tracker/logs/`;
do
	/opt/tracker/entry.sh $f $1
done