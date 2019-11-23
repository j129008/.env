# feature list: http://vimdoc.sourceforge.net/htmldoc/various.html#+feature-list

make distclean

./configure \
    --with-features=huge \
    --enable-multibyte \
    --enable-python3interp=yes \
    --with-python3-command=python3 \
    --enable-luainterp=yes \
    --with-lua-prefix=/usr/include/lua5.3 \
    --enable-cscope \
    --enable-fontset \
    --enable-largefile \
    --disable-netbeans \
    --enable-fail-if-missing \
    --prefix=/usr/local
