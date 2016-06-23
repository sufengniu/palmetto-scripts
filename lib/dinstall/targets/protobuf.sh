# returns true if it is installed
is_installed_protobuf () {
    is_stowed protobuf
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_protobuf () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install protobuf while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc gflags
}

uninstall_protobuf () {
    unstow protobuf
}

install_protobuf () {
    cd $TMPDIR
    git clone https://github.com/google/protobuf.git
    cd protobuf
    ./autogen.sh
    ./configure --prefix=$INSTALL_DIR/stow/protobuf
    make -j$cores
    make install

    dostow protobuf

    cd $TMPDIR/protobuf/python
    python setup.py install --user

    cd $TMPDIR
    rm -rf protobuf
}

