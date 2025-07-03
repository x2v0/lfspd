#!/bin/bash
# set -x  # Раскомментируйте для отладки

# Проверка версии (предполагается, что скрипт 
version-check.sh существует)
if ! ./version-check.sh; then
  echo "Ошибка: проверка версии не пройдена."
  exit 1
fi

# Очистка временных файлов
rm -f a.out

# Настройка переменных окружения
export LFS=/mnt/LFS
export LFS_TGT=x86_64-lfs-linux-gnu

# Создание и монтирование LFS-раздела
sudo mkdir -pv "$LFS" || { echo "Ошибка: не 
удалось создать директорию $LFS"; exit 1; }
sudo mount "$LFS" || { echo "Ошибка: не удалось 
смонтировать $LFS"; exit 1; }
sudo chown -v lfs.lfs "$LFS" || { echo "Ошибка: 
не удалось изменить владельца $LFS"; exit 1; }

# Создание необходимых директорий
mkdir -pv "$LFS"/sources || { echo "Ошибка: не 
удалось создать $LFS/sources"; exit 1; }
chmod -v a+wt "$LFS"/sources || { echo "Ошибка: 
не удалось изменить права доступа для 
$LFS/sources"; exit 1; }
mkdir -pv "$LFS"/tools || { echo "Ошибка: не 
удалось создать $LFS/tools"; exit 1; }
mkdir -pv "$LFS"/{etc,var,boot} 
"$LFS"/usr/{bin,lib,sbin} || { echo "Ошибка: не 
удалось создать директории"; exit 1; }

# Назначение прав пользователю lfs
chown -v lfs.lfs "$LFS"/{usr{,/*},var,etc,tools} 
|| { echo "Ошибка: не удалось изменить 
владельца"; exit 1; }

# Создание символических ссылок
for dir in bin lib sbin; do
  sudo ln -sv "usr/$dir" "$LFS/$dir" || { echo 
"Ошибка: не удалось создать символическую ссылку 
для $dir"; exit 1; }
done

# Создание директории lib64 для 64-битных систем
case $(uname -m) in
  x86_64) mkdir -pv "$LFS"/lib64 || { echo 
"Ошибка: не удалось создать $LFS/lib64"; exit 1; 
} ;;
esac

# Копирование необходимых файлов
cp -rf *.sh Dockerfile .bash* md5sums wget-list 
Chapter* "$LFS/sources" || { echo "Ошибка: не 
удалось скопировать файлы"; exit 1; }
cd "$LFS/sources" || { echo "Ошибка: не удалось 
перейти в $LFS/sources"; exit 1; }
export PATH="$LFS/tools/bin:$PATH"

# Загрузка исходных кодов
source "$LFS/sources/download.sh" || { echo 
"Ошибка: не удалось загрузить исходные коды"; 
exit 1; }

# Установка флагов для параллельной сборки
# export MAKEFLAGS="-j$(nproc)"

# Назначение прав на выполнение скриптов
chmod ugo+x preparechroot.sh 
insidechroot{1..5}.sh || { echo "Ошибка: не 
удалось изменить права доступа для скриптов"; 
exit 1; }

# Назначение прав на выполнение всех скриптов в 
Chapter*
list=$(ls Chapter*/*.sh | awk '{print $1}')
for file in $list; do
  chmod ugo+x "$file" || { echo "Ошибка: не 
удалось изменить права доступа для $file"; exit 
1; }
done

# Установка пакетов для главы 5
for p in binutils gcc linux glibc; do
  source packageinstall.sh 5 "$p" || { echo 
"Ошибка: не удалось установить $p"; exit 1; }
done

# Установка libstdc++ для GCC
pushd "$LFS/sources/gcc" || { echo "Ошибка: не 
удалось перейти в $LFS/sources/gcc"; exit 1; }
source "$LFS/sources/Chapter5/libstc.sh" || { 
echo "Ошибка: не удалось выполнить libstc.sh"; 
exit 1; }
popd || { echo "Ошибка: не удалось вернуться из 
директории"; exit 1; }

# Установка пакетов для главы 6
for p in m4 ncurses bash coreutils help2man 
diffutils file findutils gawk grep gzip make 
patch sed tar xz binutils gcc; do
  source packageinstall.sh 6 "$p" || { echo 
"Ошибка: не удалось установить $p"; exit 1; }
done

# Подготовка и вход в chroot-окружение
sudo ./preparechroot.sh "$LFS" || { echo "Ошибка: 
не удалось подготовить chroot"; exit 1; }
echo "Вход в CHROOT-окружение..."
sleep 3

# Выполнение скриптов внутри chroot
for script in insidechroot{1..5}.sh; do
  echo "Запуск $script в CHROOT!"
  sleep 3
  sudo chroot "$LFS" /usr/bin/env \
    HOME=/root \
    TERM="$TERM" \
    PS1='(lfs chroot) \u:\w\$ ' \
    
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin 
\
    TESTERUID=$UID \
    /bin/bash --login +h -c "/sources/$script" || 
{ echo "Ошибка: не удалось выполнить $script"; 
exit 1; }
done

echo "Настройка LFS завершена успешно."
