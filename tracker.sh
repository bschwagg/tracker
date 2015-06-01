#!/bin/bash
#TODO: create a python script here with options for reports, etc.
if [[ $1 ]] ; then
  cat /opt/tracker/logs/$1
else
  #echo "Dumping all projects:"
  for i in `ls /opt/tracker/logs/`; do
    echo "* Project $i"
    cat /opt/tracker/logs/$i
    echo "* -------------------------"
  done
fi
