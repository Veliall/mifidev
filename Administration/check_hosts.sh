#!/bin/bash

# Список хостов для проверки (IP-адреса или доменные имена)
hosts=("192.168.1.1" "192.168.1.2" "google.com" "yandex.ru")

# Счетчики доступных и недоступных хостов
available=0
unavailable=0

# Проверка наличия хостов в списке
if [ ${#hosts[@]} -eq 0 ]; then
    echo "Ошибка: список хостов пуст."
    exit 1
fi

# Проверка доступности хостов
for host in "${hosts[@]}"; do
    # Пинг 1 раз с ожиданием 1 секунды
    if ping -c 1 -W 1 "$host" &> /dev/null; then
        echo "Хост $host доступен"
        ((available++))
    else
        echo "Хост $host недоступен"
        ((unavailable++))
    fi
done

# Итоговый вывод
echo
echo "Доступных хостов: $available"
echo "Недоступных хостов: $unavailable"
