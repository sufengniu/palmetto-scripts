# returns true if it is installed
is_installed_gflags () {
    is_stowed gflags
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_gflags () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install gflags while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc cmake
}

uninstall_gflags () {
    unstow gflags
}

install_gflags () {
    cd $TMPDIR
    git clone https://github.com/schuhschuh/gflags.git
    mkdir gflags/build
    cd gflags/build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/stow/gflags \
       -DCMAKE_PREFIX_PATH=$INSTALL_DIR -DBUILD_SHARED_LIBS=ON ..
    make -j$cores
    make install

    dostow gflags

    cd $TMPDIR
    rm -rf gflags
}

binary_deploy_gflags () {
    binary_deploy_stow gflags
}
binary_install_gflags () {
    binary_install_stow gflags
}
binary_available_gflags () {
    binary_available_stow gflags
}
