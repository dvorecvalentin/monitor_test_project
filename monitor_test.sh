#!/bin/bash

# Лог-файл
LOG_FILE="/var/log/monitoring.log"

# URL для мониторинга
MONITORING_URL="https://test.com/monitoring/test/api"

# Имя процесса
PROCESS_NAME="test"

# Проверка, запущен ли процесс
if pgrep -x "$PROCESS_NAME" > /dev/null; then
    # Процесс запущен, отправляем запрос на сервер мониторинга
    if curl -s -o /dev/null -w "%{http_code}" "$MONITORING_URL" | grep -q "200"; then
        # Сервер доступен, ничего не делаем
        :
    else
        # Сервер недоступен, пишем в лог
        echo "$(date): Сервер мониторинга недоступен" >> "$LOG_FILE"
    fi
else
    # Процесс не запущен, ничего не делаем
    :
fi

# Проверка, был ли процесс перезапущен
if [ -f /tmp/last_pid ]; then
    LAST_PID=$(cat /tmp/last_pid)
    CURRENT_PID=$(pgrep -x "$PROCESS_NAME")
    if [ "$LAST_PID" != "$CURRENT_PID" ] && [ -n "$CURRENT_PID" ]; then
        # Процесс был перезапущен, пишем в лог
        echo "$(date): Процесс $PROCESS_NAME был перезапущен, новый PID: $CURRENT_PID" >> "$LOG_FILE"
    fi
fi

# Сохраняем текущий PID процесса
pgrep -x "$PROCESS_NAME" > /tmp/last_pid
