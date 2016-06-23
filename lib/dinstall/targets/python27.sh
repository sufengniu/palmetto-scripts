# returns true if it is installed
is_installed_python27 () {
    is_stowed python27
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_python27 () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install cmake while on the user node. try getGPULikeNode first!"
        return 1
    fi
    if [ $(which python) != "/usr/bin/python" ]; then
        echo "You already have some python distribution installed! That can mess with things. Please disable it."
        echo "which python should return \"/usr/bin/python\", not \"$(which python)\""
        return 1
    fi
    require_packages gcc
}

uninstall_python27 () {
    unstow python27
}

install_python27 () {
    cd $TMPDIR
    mkdir python27; cd python27
    wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz
    tar -xf Python-2.7.11.tgz
    cd Python-2.7.11
    ./configure --prefix=$INSTALL_DIR/stow/python27 --enable-shared
    make -j$cores
    make install

    dostow python27

    cd $TMPDIR
    wget https://bootstrap.pypa.io/ez_setup.py -O - | python - --user

    rm -rf python27
}

binary_deploy_python27 () {
    binary_deploy_stow python27
}
binary_install_python27 () {
    binary_install_stow python27

    cd $TMPDIR
    wget https://bootstrap.pypa.io/ez_setup.py -O - | python - --user
}
binary_available_python27 () {
    binary_available_stow python27
}
