#!/bin/bash

# Проверяем, существует ли процесс nginx через /proc
if [ -d /proc/1 ] && [ "$(cat /proc/1/comm)" = "nginx" ]; then
  echo "Nginx is running."
else
  echo "Nginx is not running!" >&2
  exit 1
fi

# Проверяем доступность HTTP на порту 80
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)
if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "HTTP is accessible, status code: $HTTP_STATUS"
else
  echo "HTTP check failed, status code: $HTTP_STATUS" >&2
  exit 1
fi

echo "All tests passed!"
exit 0
