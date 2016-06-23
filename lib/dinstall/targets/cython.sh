# returns true if it is installed
is_installed_cython () {
    python -m pip show cython &> /dev/null
}

# will exit with error if dependencies are not met 
# (0 means dependencies met, 1 means not met)
dependencies_satisfied_cython () {
    if [ $HOSTNAME = "user001" ]; then
        echo "Cannot install cython while on the user node. try getGPULikeNode first!"
        return 1
    fi
    require_packages python27 pip
}

uninstall_cython () {
    python -m pip uninstall -y cython
}

install_cython () {
    python -m pip install cython
}
