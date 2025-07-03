#!/bin/bash

# Скрипт для создания архива lfspd.10.tar из Docker-образа xtovo/lfspd

# Переменные
IMAGE_NAME="xtovo/lfspd"
TMP_TAR="tmp.tar"
OUTPUT_TAR="lfspd.10.tar"
DISTROS_DIR="./Distros"

# Переход в директорию Distros
if ! cd "$DISTROS_DIR"; then
  echo "Ошибка: Не удалось перейти в директорию $DISTROS_DIR."
  exit 1
fi

# Загрузка Docker-образа
echo "Загрузка Docker-образа $IMAGE_NAME..."
if ! docker pull "$IMAGE_NAME"; then
  echo "Ошибка: Не удалось загрузить Docker-образ $IMAGE_NAME."
  exit 1
fi

# Сохранение Docker-образа в tar-архив
echo "Сохранение Docker-образа в $TMP_TAR..."
if ! docker save -o "$TMP_TAR" "$IMAGE_NAME"; then
  echo "Ошибка: Не удалось сохранить Docker-образ в $TMP_TAR."
  exit 1
fi

# Распаковка tar-архива
echo "Распаковка $TMP_TAR..."
if ! tar -xf "$TMP_TAR"; then
  echo "Ошибка: Не удалось распаковать $TMP_TAR."
  exit 1
fi

# Поиск временной директории
tmp_dir=$(find . -mindepth 1 -maxdepth 1 -type d)
if [ -z "$tmp_dir" ]; then
  echo "Ошибка: Не удалось найти временную директорию."
  exit 1
fi

# Переименование layer.tar в lfspd.10.tar
echo "Переименование layer.tar в $OUTPUT_TAR..."
if ! mv "${tmp_dir}/layer.tar" "$OUTPUT_TAR"; then
  echo "Ошибка: Не удалось переместить ${tmp_dir}/layer.tar в $OUTPUT_TAR."
  exit 1
fi

# Очистка временных файлов
echo "Очистка временных файлов..."
rm -f *.json *.md repositories "$TMP_TAR"
rm -rf "$tmp_dir"

echo "Архив $OUTPUT_TAR успешно создан."
