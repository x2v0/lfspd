CHAPTER="$1"
PACKAGE="$2"

cat md5sums | cut -d ' ' -f 3 | grep -i "^$PACKAGE" | grep -i -v "\.patch" | while read line; do
    FILENAME="$line"
    DIRNAME="$(echo "$PACKAGE" | sed 's/\(.*\)\.tar\..*/\1/')"

    if [ -d "$DIRNAME" ]; then
        rm -rf "$DIRNAME"
    fi

    mkdir -pv $DIRNAME

    echo "===>Extracting $PACKAGE..."
    tar -xvf "$FILENAME" -C "$DIRNAME"
    pushd $DIRNAME
    if [ "$(ls -A1 | wc -l)" == "1" ]; then
        mv $(ls -A1)/* ./
    fi

    echo "===>Compiling $PACKAGE..."
    sleep 5
    
    mkdir -pv "$LFS/var/log/Chapter$CHAPTER/"
    if ! source "$LFS/sources/Chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "$LFS/var/log/Chapter$CHAPTER/$PACKAGE.log"; then
        echo "Compiling $PACKAGE failed!"
        popd
        exit 1
    fi

    echo "===>Done compiling $PACKAGE!"
    sleep 3
    popd

done

