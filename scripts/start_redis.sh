#!/usr/bin/env bash
nohup redis-server >/workspace/logs/redis.log 2>&1 &
echo "Redis started"
echo "Log file: /workspace/logs/redis.log"
