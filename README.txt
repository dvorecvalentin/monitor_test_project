Мониторинг процесса test

Этот проект предназначен для мониторинга процесса `test` в Linux. Он включает:

- Bash-скрипт `monitor_test.sh` для проверки состояния процесса и отправки запросов на сервер мониторинга.
- Юнит и таймер systemd для автоматического запуска скрипта каждую минуту.

Установка:

1. Скопируйте файлы на их исходные места:

   sudo cp monitor_test.service /etc/systemd/system/
   sudo cp monitor_test.timer /etc/systemd/system/
   sudo cp monitor_test.sh /usr/local/bin/
   sudo cp monitoring.log /var/log/
   sudo cp last_pid /tmp/

2. Убедитесь, что права доступа корректны:

   sudo chmod +x /usr/local/bin/monitor_test.sh
   sudo chown root:root /etc/systemd/system/monitor_test.*

3. Включите и запустите таймер:

   sudo systemctl enable monitor_test.timer
   sudo systemctl start monitor_test.timer

Логи:

Логи записываются в файл /var/log/monitoring.log.