# returns true if it is installed
is_installed_ipdb () {
    python -c "import ipdb"
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_ipdb () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install ipdb while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27
}

uninstall_ipdb () {
    echo "TODO"
}

install_ipdb () {
    cd $TMPDIR
    mkdir ipdb; cd ipdb

    wget https://pypi.python.org/packages/source/i/ipdb/ipdb-0.9.0.tar.gz
    tar xf ipdb-0.9.0.tar.gz
    cd ipdb-0.9.0
    python setup.py install --user
    cd ..

    cd $TMPDIR
    rm -rf ipdb
}
