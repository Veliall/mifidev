#!/bin/bash

# Указываем директорию для поиска лог-файлов
log_directory="/Administration/logs"

# Ключевое слово для поиска
keyword="ERROR"

# Проверяем, существует ли указанная директория
if [ ! -d "$log_directory" ]; then
    echo "Ошибка: директория $log_directory не найдена."
    exit 1
fi

# Инициализация переменной для общего количества строк с ключевым словом
total_count=0

# Поиск всех лог-файлов в указанной директории и подсчет строк с ключевым словом
for logfile in "$log_directory"/*.log; do
    # Проверка на наличие лог-файлов
    if [ ! -e "$logfile" ]; then
        echo "Лог-файлы не найдены в директории $log_directory."
        exit 1
    fi

    # Подсчет строк с ключевым словом в текущем файле
    count=$(grep -c "$keyword" "$logfile")

    # Вывод информации для каждого лог-файла
    echo "Файл $logfile содержит $count строк с ключевым словом $keyword"

    # Увеличение общего счетчика
    total_count=$((total_count + count))
done

# Вывод общего количества строк с ключевым словом
echo
echo "Общее количество строк с ключевым словом '$keyword' по всем файлам: $total_count"
