#!/bin/bash

LOG_FILE="/home/ec2-user/learning/phase4/sysht.log"

DATE=$(date)
HOSTNAME=$(hostname)

echo "--------------------------" >> $LOG_FILE
echo "Health check at [ $DATE ] on [ $HOSTNAME ]" >> $LOG_FILE


USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
echo "Disk Usage: $USAGE%" >> $LOG_FILE
