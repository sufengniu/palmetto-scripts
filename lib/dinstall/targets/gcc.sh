

# returns true if gcc is installed
is_installed_gcc () {
    return is_stowed gcc
}


# will exit with error if dependencies are not met
check_dependencies_gcc () {
    return
}

uninstall_gcc () {
    unstow gcc
}

install_gcc () {
    cd $TMPDIR
    mkdir gcc; cd gcc

    wget http://mirrors-usa.go-parts.com/gcc/releases/gcc-4.8.2/gcc-4.8.2.tar.gz
    tar xf gcc-4.8.2.tar.gz
    mkdir gcc-4.8.2/build
    cd gcc-4.8.2/build
    ../configure --disable-multilib --prefix=$INSTALL_DIR/stow/gcc --with-mpfr=$INSTALL_DIR
    make -j$cores
    make 
    make install
    dostow gcc

    cd $TMPDIR
    rm -rf gcc
}
