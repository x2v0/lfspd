#!/bin/bash

# Проверка прав root
if [ $EUID -ne 0 ]; then
  echo "Ошибка: скрипт должен быть запущен от 
имени root."
  exit 1
fi

# Очистка ненужных файлов и директорий
echo "Очистка ненужных файлов и директорий..."
rm -rf 
/usr/{share,local,local/share,lib,local/lib}/{loca
le,info,man,doc,docs,test,tests,examples,tutorials
,README}/*
find /usr/{lib,libexec,local/lib} -name '*.la' 
-delete
rm -rf /tools
rm -rf /var/log/*
rm -rf /root/.*

# Сохранение важных файлов из /sources/
echo "Сохранение важных файлов из /sources/..."
mkdir -p /sav
cd /sources || { echo "Ошибка: не удалось перейти 
в /sources"; exit 1; }
cp -rf *.sh .bash* md5sums wget-list Chapter* 
/sav/
cd .. || { echo "Ошибка: не удалось вернуться из 
/sources"; exit 1; }
rm -rf /sources/*
cp -rf /sav/* /sources/
rm -rf /sav

# Оптимизация файлов
echo "Оптимизация файлов..."
last_fs_inode=
last_file=

{
  find /usr/{lib,local/lib} -type f -name '*.so*' 
! -name '*dbg'
  find /usr/lib -type f -name '*.a'
  find 
/usr/{bin,sbin,libexec,local/bin,local/sbin} 
-type f
} | xargs stat -c '%m %i %n' | sort | while read 
-r fs inode file; do
  # Пропустить файлы, которые не являются 
исполняемыми
  if ! readelf -h "$file" >/dev/null 2>&1; then
    continue
  fi

  # Пропустить файлы, которые уже оптимизированы
  if file "$file" | grep --quiet --invert-match 
'not stripped'; then
    continue
  fi

  # Создать жесткую ссылку, если файл уже был 
обработан
  if [ "$fs $inode" = "$last_fs_inode" ]; then
    ln -f "$last_file" "$file"
    continue
  fi

  # Оптимизация файла
  cp --preserve "$file" "${file}.tmp"
  strip --strip-unneeded "${file}.tmp"
  mv "${file}.tmp" "$file"

  # Сохранить информацию о последнем обработанном 
файле
  last_fs_inode="$fs $inode"
  last_file="$file"
done

echo "Оптимизация завершена успешно."
