# System Health Monitoring Script

## Overview
This Project is a Bash-Based System monitoring tool that checks system health metrics such as disk usage, memory usage, and CPU usage.

It logs system data and sends real time-time alerts using the Telegram API when thersholds are exceeded.

---

## Features
- Disk Space Monitoring
- Memory Usage Monitoring
- CPU Usage Monitoring
- Logging to File
- Telegram alert notification
- Cron automation support

----

## Technologies used
- Linux
- Bash
- Cron
- Telegram Bot API

## How it works
1. Script collects system matrics using Linux Commands ('df','free',`top`)

