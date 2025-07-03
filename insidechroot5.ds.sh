#!/bin/bash

# Экспорт флагов компилятора
export CFLAGS="-Wno-error -Os"
export LFS=""

# Директории
SOURCE_DIR="/sources"
LOG_DIR="/var/log/Chapter10"
CHAPTER_DIR="Chapter10"

# Проверка наличия директории с исходниками
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Ошибка: Директория с исходниками $SOURCE_DIR не найдена."
  exit 1
fi

# Создание директории для логов
if ! mkdir -p "$LOG_DIR"; then
  echo "Ошибка: Не удалось создать директорию для логов $LOG_DIR."
  exit 1
fi

# Переход в директорию с исходниками
if ! cd "$SOURCE_DIR"; then
  echo "Ошибка: Не удалось перейти в директорию $SOURCE_DIR."
  exit 1
fi

# Функция для установки пакетов
doit() {
  local package_name=$1
  local script_path="${CHAPTER_DIR}/${package_name}.sh"
  local log_file="${LOG_DIR}/${package_name}.log"

  # Проверка наличия скрипта
  if [ ! -f "$script_path" ]; then
    echo "Ошибка: Скрипт для пакета $package_name не найден ($script_path)."
    return 1
  fi

  echo "Установка пакета $package_name..."
  
  # Запуск скрипта с логированием
  if ! source "$script_path" 2>&1 | tee "$log_file"; then
    echo "Ошибка: Не удалось установить пакет $package_name."
    return 1
  fi

  echo "Пакет $package_name успешно установлен."
  return 0
}

# Список пакетов для установки
packages=(
  "veccore" "VecGeom" "libfmt" "fastjet" "gperftools" "jemalloc" "root" "geant"
  "gaudi" "HepMC3" "HepMC" "pythia" "evtgen" "podio" "EDM4hep" "DD4hep" "GeoModel"
  "acts" "Vc" "KFParticle"
)

# Установка пакетов
for package in "${packages[@]}"; do
  if ! doit "$package"; then
    echo "Прерывание установки из-за ошибки в пакете $package."
    exit 1
  fi
done

# Установка Python-пакетов
if [ -f "${CHAPTER_DIR}/py-packages.sh" ]; then
  echo "Установка Python-пакетов..."
  if ! source "${CHAPTER_DIR}/py-packages.sh" 2>&1 | tee "${LOG_DIR}/py-packages.log"; then
    echo "Ошибка: Не удалось установить Python-пакеты."
    exit 1
  fi
else
  echo "Ошибка: Скрипт для установки Python-пакетов не найден."
  exit 1
fi

echo "Установка всех пакетов завершена успешно."
