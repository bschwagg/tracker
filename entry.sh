#!/bin/bash
 
 export FORMAT='%F %T'
 export FILE="/opt/tracker/logs/$1"

 echo $(date +"$NOW_FORMAT") - "$2" >> ${FILE}
