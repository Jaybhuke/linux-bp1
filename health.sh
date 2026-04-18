#!/bin/bash

LOG_FILE="/home/ec2-user/learning/phase4/sysht.log"

DATE=$(date)
HOSTNAME=$(hostname)
TOKEN="8696906102:AAEO-qihs7tBuwWPft07AvQWYOUlJ7RifHw"
CHAT_ID="7675100712"


echo "--------------------------" >> $LOG_FILE
echo "Health check at [ $DATE ] on [ $HOSTNAME ]" >> $LOG_FILE


USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
echo "Disk Usage: $USAGE%" >> $LOG_FILE


MEMORY=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')
echo "Memory Usage: $MEMORY%" >> $LOG_FILE


CPU=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU%" >> $LOG_FILE

if [ $USAGE -gt 80 ]; then
	echo "Disk Usage High: $USAGE%" >> $LOG_FILE
fi

if (( $(echo "$MEMORY > 80" | bc -l) )); then
	echo "Memory Usage High: $MEMORY%" >> $LOG_FILE
fi

if (( $(echo "$CPU > 80" | bc -l) )); then
	echo "CPU Usage High: $CPU%" >> $LOG_FILE
fi

echo "----Alert Sent to Telegram----" >> $LOG_FILE
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
-d chat_id=$CHAT_ID \
-d text="Test for linux" 



echo "--------------------------" >> $LOG_FILE
