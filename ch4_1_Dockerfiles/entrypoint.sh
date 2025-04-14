#!/bin/bash

# Listen 포트 동적으로 적용
CONF="/etc/httpd/conf/httpd.conf"
if grep -q '^Listen' "$CONF"; then
    sed -i "s/^Listen .*/Listen ${APP_PORT}/" "$CONF"
else
    echo "Listen ${APP_PORT}" >> "$CONF"
fi

# Apache 실행
exec /usr/sbin/httpd "$@"