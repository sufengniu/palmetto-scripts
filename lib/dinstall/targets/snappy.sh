# returns true if it is installed
is_installed_snappy () {
    is_stowed snappy
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_snappy () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install snappy while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc
}

uninstall_snappy () {
    unstow snappy
}

install_snappy () {
    cd $TMPDIR
    git clone https://github.com/google/snappy.git
    cd snappy
    ./autogen.sh
    ./configure --prefix=$INSTALL_DIR/stow/snappy
    make -j$cores
    make install

    dostow snappy

    cd $TMPDIR
    rm -rf snappy
}

binary_deploy_snappy () {
    binary_deploy_stow snappy
}
binary_install_snappy () {
    binary_install_stow snappy
}
binary_available_snappy () {
    binary_available_stow snappy
}
