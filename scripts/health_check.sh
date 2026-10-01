#!/bin/bash

echo "==============================="
echo "  LINUX SYSTEM HEALTH CHECK "
echo "==============================="
echo "Hostname:$(hostname)"
echo "Current User:$(whoami)"
echo "Current Date:$(date)"
echo "Uptime:$(uptime -p)"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{printf"%.0f",100 - $8}')
echo "CPU Usage:$CPU_USAGE%"

RAM_USAGE=$(free -m | awk '/Mem:/ {printf "%.1f", $3/$2*100}')
echo "RAM Usage:$RAM_USAGE%"
DISK_USAGE=$(df -h / | awk 'NR==2 {gsub(/"%"/,"",$5);print $5+0}')
echo "Disk Usage:$DISK_USAGE"
echo "---------------------------------"
if((${CPU_USAGE%.*} >= 80 )); then
   echo "CPU status:WARNING"
else
    echo "CPU status:OK"
fi
if ((${RAM_USAGE%.*} >= 80 )); then
    echo "RAM status: WARNING"
else
    echo "RAM status :OK"
fi
if (( DISK_USAGE >= 80 )); then
    echo "DISK status:  WARNING"
else
    echo "DISK status:OK"
fi

echo "==============================="


