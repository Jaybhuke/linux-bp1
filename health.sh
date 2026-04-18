#!/bin/bash

LOG_FILE="/home/ec2-user/learning/phase4/sysht.log"
source /home/ec2-user/learning/phase4/.env

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

if [ $USAGE -gt 80 ]; then
	echo "Disk Usage High: $USAGE%" >> $LOG_FILE
fi

if (( $(echo "$MEMORY > 80" | bc -l) )); then
	echo "Memory Usage High: $MEMORY%" >> $LOG_FILE
fi

if (( $(echo "$CPU > 80" | bc -l) )); then
	echo "CPU Usage High: $CPU%" >> $LOG_FILE
fi

MESSAGE1="Alert: DISK:$USAGE% MEMORY:$MEMORY% CPU:$CPU% on $HOSTNAME"

echo "----Sending Alert to Telegram----" >> $LOG_FILE
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
-d chat_id=$CHAT_ID --data-urlencode "text=$MESSAGE1"

echo "$MESSAGE1" >> $LOG_FILE

if [ $USAGE -gt 80 ] || \
	(( $(echo "$MEMORY > 80" | bc -l) )) || \
	(( $(echo "$CPU > 80" | bc -l) )); then
	
	MESSAGE="Alert: DISK:$USAGE% MEMORY:$MEMORY% CPU:$CPU% on $HOSTNAME"

	echo "$MESSAGE" >> $LOG_FILE

	curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" --data-urlencode "chat_id=$CHAT_ID" --data-urlencode "text=$MESSAGE"

fi
	



echo "--------------------------" >> $LOG_FILE
