# returns true if it is installed
is_installed_pip () {
    python -m pip --version &> /dev/null
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_pip () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install pip while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27
}

uninstall_pip () {
    echo "TODO"
}

install_pip () {
    cd $TMPDIR
    mkdir pip; cd pip

    wget https://bootstrap.pypa.io/get-pip.py 
    python get-pip.py

    cd $TMPDIR
    rm -rf pip
}
