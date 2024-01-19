#!/bin/bash

HEALTH_CHECK_ENDPOINT="http://localhost:5000/health"

if curl --silent --fail "$HEALTH_CHECK_ENDPOINT"; then
  echo "App is healthy"
  exit 0
else
  echo "App is unhealthy"
  exit 1
fi