#!/usr/bin/env bash

cd /workspace/kohya_ss
source venv/bin/activate
nohup fastapi run --port 8001 >/workspace/logs/fastapi.log 2>&1 &
deactivate
