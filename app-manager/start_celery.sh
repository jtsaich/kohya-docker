#!/usr/bin/env bash

cd /workspace
source kohya_ss/venv/bin/activate
nohup celery -A kohya_ss.celery_app worker -c 1 --loglevel=info >/workspace/logs/celery.log 2>&1 &
deactivate
