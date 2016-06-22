

# returns true if gcc is installed
is_installed_gcc () {
    is_stowed gcc
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_gcc () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install gcc while on the user node. try getGPULikeNode first!"
        return 1
    fi
    return 0
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
