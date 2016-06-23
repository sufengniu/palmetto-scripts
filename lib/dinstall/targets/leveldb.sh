# returns true if it is installed
is_installed_leveldb () {
    is_stowed leveldb
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_leveldb () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install leveldb while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc
}

uninstall_leveldb () {
    unstow leveldb
}

install_leveldb () {
    cd $TMPDIR
    git clone https://github.com/google/leveldb.git
    cd leveldb
    
    #see https://github.com/google/leveldb/issues/340 :
    sed -i -e 's/std::uint64_t/uint64_t/' db/recovery_test.cc
    
    make -j$cores
    mkdir -p $INSTALL_DIR/stow/leveldb/lib
    mkdir -p $INSTALL_DIR/stow/leveldb/include
    cp --preserve=links out-shared/libleveldb.* $INSTALL_DIR/stow/leveldb/lib
    cp -r include/leveldb $INSTALL_DIR/stow/leveldb/include
    cd ..

    dostow leveldb

    cd $TMPDIR
    rm -rf leveldb
}

binary_deploy_leveldb () {
    binary_deploy_stow leveldb
}
binary_install_leveldb () {
    binary_install_stow leveldb
}
binary_available_leveldb () {
    binary_available_stow leveldb
}
