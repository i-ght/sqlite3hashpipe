CFLAGS="-I./include -I./src -I$HOME/.local/include"
LFLAGS=""

for dotc_file in ./src/*.c; do
  clang -g -DDEBUG=1 -fPIC -c "$dotc_file" $CFLAGS -o "$dotc_file.o"
done

doto_files=""

for doto_file in ./src/*.c.o; do
  doto_files="${doto_files} ${doto_file}"
done

ar rcs bin/libhashpipe.a $doto_files
clang -g -DDEBUG=1 -shared -o bin/libhashpipe.so $doto_files $LFLAGS $CFLAGS
 
clang -g -DDEBUG=1 -o bin/program program/program.c -I./include -L./bin -l:libhashpipe.a

rm ./src/*.c.o

install='install'
uninstall='uninstall'

case "$1" in
  "$install")
    cp bin/libhashpipe.so ~/.local/lib/
    cp bin/libhashpipe.a ~/.local/lib/
    cp include/hash.h ~/.local/include
  ;;
  "$uninstall")
    rm ~/.local/lib/libhashpipe.so
    rm ~/.local/lib/libhashpipe.a
    rm ~/.local/include/hash.h
  ;;
  *)
    
  ;;
esac
