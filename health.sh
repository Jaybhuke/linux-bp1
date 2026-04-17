#!/bin/bash

LOG_FILE="/home/ec2-user/learning/phase4/sysht.log"

DATE=$(date)
HOSTNAME=$(hostname)

echo "--------------------------" >> $LOG_FILE
echo "Health check at [ $DATE ] on [ $HOSTNAME ]" >> $LOG_FILE


USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
echo "Disk Usage: $USAGE%" >> $LOG_FILE


MEMORY=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')
echo "Memory Usage: $MEMORY%" >> $LOG_FILE


CPU=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU%" >> $LOG_FILE

echo "--------------------------" >> $LOG_FILE
