# returns true if it is installed
is_installed_opencv () {
    is_stowed opencv
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_opencv () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install opencv while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27 pip numpy cmake gcc
}

uninstall_opencv () {
    unstow opencv
}

install_opencv () {
    cd $TMPDIR

    git clone https://github.com/Itseez/opencv.git
    cd opencv
    mkdir build
    cd build
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/stow/opencv \
        -DCMAKE_PREFIX_PATH=$INSTALL_DIR  -DBUILD_JPEG=ON \
        -DBUILD_JASPER=ON -DBUILD_TIFF=ON -DWITH_IPP=OFF ..
    make -j$cores
    make install

    dostow opencv

    cd $TMPDIR
    rm -rf opencv
}

binary_deploy_opencv () {
    binary_deploy_stow opencv
}
binary_install_opencv () {
    binary_install_stow opencv
}
binary_available_opencv () {
    binary_available_stow opencv
}
