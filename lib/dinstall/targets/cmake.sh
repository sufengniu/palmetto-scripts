# returns true if it is installed
is_installed_cmake () {
    is_stowed cmake
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_cmake () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install cmake while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc
}

uninstall_cmake () {
    unstow cmake
}

install_cmake () {
    cd $TMPDIR
    
    wget --no-check-certificate http://cmake.org/files/v3.5/cmake-3.5.2.tar.gz    
    tar xf cmake-3.5.2.tar.gz
    cd cmake-3.5.2
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/stow/cmake \
        -DCMAKE_PREFIX_PATH=$INSTALL_DIR .
    make -j$cores
    make install

    dostow cmake

    cd $TMPDIR
    rm -rf cmake-3.5.2
}

binary_deploy_cmake () {
    binary_deploy_stow cmake
}
binary_install_cmake () {
    binary_install_stow cmake
}
binary_available_cmake () {
    binary_available_stow cmake
}
