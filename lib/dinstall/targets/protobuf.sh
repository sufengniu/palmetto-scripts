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
    require_packages gcc gflags python27 pip
}

uninstall_protobuf () {
    unstow protobuf
    python -m pip uninstall -y protobuf
}

install_protobuf () {
    cd $TMPDIR
    git clone https://github.com/google/protobuf.git
    cd protobuf
    ./autogen.sh
    ./configure --prefix=$INSTALL_DIR/stow/protobuf
    make -j$cores
    make install

    cp -r $TMPDIR/protobuf $INSTALL_DIR/stow/protobuf/protobuf-src
    echo "\\prototbuf-src" >> $INSTALL_DIR/stow/protobuf/.stow-local-ignore

    dostow protobuf

    cd $INSTALL_DIR/stow/protobuf/protobuf-src/python
    python setup.py install --user

    cd $TMPDIR
    rm -rf protobuf
}

binary_deploy_protobuf () {
    cd $INSTALL_DIR/stow
    tar -czvf $binary_path/protobuf.tar.gz protobuf
}
binary_install_protobuf () {
    cd $INSTALL_DIR/stow
    tar -xvf $binary_path/protobuf.tar.gz
    dostow protobuf

    cd $INSTALL_DIR/stow/protobuf/protobuf-src/python
    python setup.py install --user
}
binary_available_protobuf () {
    test -f $binary_path/protobuf.tar.gz
}


