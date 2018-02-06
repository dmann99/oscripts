#!/bin/sh

# Name        : chkmountusage.sh
# Description : Check mounts and send email if any mounts > 90% used
# Author      : David Mann
# Changes     : 2019-02-06

THRESH=95
USEREMAIL=user@email.com
HOSTNAME=`hostname`

df -h | awk '{print $5,$2,"/",$1,$4,"\n"}' | tr -d "%d" | sort -k 5 | awk -v Thresh=$THRESH ' $5 >= Thresh ' $f > /tmp/.usagecheck

LINES=`cat /tmp/.usagecheck | wc -l`
if [ $LINES -eq 0 ]; then
  echo "No issues found"
else
  echo "The following $HOSTNAME mounts are over the ${THRESH}% usage threshold and require attention:" > .mailcontents
  cat /tmp/.usagecheck | sed -e 's/ $/%/' >> .mailcontents

  cat .mailcontents

  mailx -s "Mount Size Check Alert - $HOSTNAME" $USEREMAIL < .mailcontents

fi

