#!/bin/bash

if [ "$(ps aux | grep -c gunicorn)" -lt 2 ]; then
  echo "App is unhealthy"
  exit 1
fi

echo "App is healthy"
exit 0