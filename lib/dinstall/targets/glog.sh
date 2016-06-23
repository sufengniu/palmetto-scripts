# returns true if it is installed
is_installed_glog () {
    is_stowed glog
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_glog () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install glog while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc cmake
}

uninstall_glog () {
    unstow glog
}

install_glog () {
    cd $TMPDIR
    git clone https://github.com/google/glog.git
    mkdir glog/build
    cd glog/build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/stow/glog \
       -DCMAKE_PREFIX_PATH=$INSTALL_DIR -DBUILD_SHARED_LIBS=ON ..
    make -j$cores
    make install

    dostow glog

    cd $TMPDIR
    rm -rf glog
}

binary_deploy_glog () {
    binary_deploy_stow glog
}
binary_install_glog () {
    binary_install_stow glog
}
binary_available_glog () {
    binary_available_stow glog
}
