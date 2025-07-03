#!/bin/bash

# Скрипт для настройки WSL (Windows Subsystem for Linux) на Windows

# Функция для проверки успешности выполнения команды
check_success() {
  if [ $? -eq 0 ]; then
    echo "Успешно: $1"
  else
    echo "Ошибка: $2"
    exit 1
  fi
}

# Шаг 1: Включение функции Virtual Machine Platform
echo "Шаг 1: Включение функции Virtual Machine Platform..."
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
check_success "Функция Virtual Machine Platform включена." "Не удалось включить Virtual Machine Platform."

# Шаг 2: Включение функции WSL
echo "Шаг 2: Включение функции Windows Subsystem for Linux..."
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
check_success "Функция Windows Subsystem for Linux включена." "Не удалось включить Windows Subsystem for Linux."

# Шаг 3: Перезагрузка системы
echo "Шаг 3: Перезагрузка системы..."
read -p "Перезагрузить систему сейчас? (y/n): " reboot_choice
if [[ $reboot_choice == "y" || $reboot_choice == "Y" ]]; then
  shutdown /r /t 0
  check_success "Система перезагружается." "Не удалось инициировать перезагрузку."
else
  echo "Перезагрузка отменена. Пожалуйста, перезагрузите систему вручную."
fi

# Шаг 4: Установка WSL 2 как версии по умолчанию
echo "Шаг 4: Установка WSL 2 как версии по умолчанию..."
wsl --set-default-version 2
check_success "WSL 2 установлен как версия по умолчанию." "Не удалось установить WSL 2 как версию по умолчанию."

echo "Настройка WSL завершена успешно."
