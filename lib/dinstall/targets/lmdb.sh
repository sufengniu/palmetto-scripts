# returns true if it is installed
is_installed_lmdb () {
    is_stowed lmdb
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_lmdb () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install lmdb while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc
}

uninstall_lmdb () {
    unstow lmdb
}

install_lmdb () {
    cd $TMPDIR
    # old:
    #git clone https://gitorious.org/mdb/mdb.git
    git clone https://github.com/wizawu/lmdb.git 
    cd lmdb/libraries/liblmdb
    sed -i -e "s|prefix.*=.*$|prefix = $INSTALL_DIR/stow/lmdb|" Makefile
    mkdir -p $INSTALL_DIR/stow/lmdb/man
    mkdir -p $INSTALL_DIR/stow/lmdb/bin
    mkdir -p $INSTALL_DIR/stow/lmdb/include
    mkdir -p $INSTALL_DIR/stow/lmdb/lib
    make -j$cores
    make install

    dostow lmdb

    cd $TMPDIR
    rm -rf lmdb
}

binary_deploy_lmdb () {
    binary_deploy_stow lmdb
}
binary_install_lmdb () {
    binary_install_stow lmdb
}
binary_available_lmdb () {
    binary_available_stow lmdb
}
