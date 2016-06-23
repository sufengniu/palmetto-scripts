# returns true if it is installed
is_installed_boost () {
    is_stowed boost
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_boost () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install boost while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages gcc
}

uninstall_boost () {
    unstow boost
}

install_boost () {
    cd $TMPDIR
    mkdir boost; cd boost
    wget http://iweb.dl.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.gz
    tar xf boost_1_60_0.tar.gz
    cd boost_1_60_0

    # See: https://svn.boost.org/trac/boost/ticket/11852
    sed -i -e '156s/$/ \&\& !defined(__CUDACC__)/' boost/config/compiler/gcc.hpp
    
    ./bootstrap.sh --prefix=$INSTALL_DIR/stow/boost
    ./b2 -j$cores install

    dostow boost

    cd $TMPDIR
    rm -rf boost
}

binary_deploy_boost () {
    binary_deploy_stow boost
}
binary_install_boost () {
    binary_install_stow boost
}
binary_available_boost () {
    binary_available_stow boost
}
